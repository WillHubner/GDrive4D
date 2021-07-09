unit GDrive4D.Classes.Drive;

interface

uses
  StrUtils,
  System.JSON,
  RESTRequest4D,
  GDrive4D.Classes.Auth,
  GDrive4D.Interfaces;

type

  TDrive = Class(TInterfacedObject, iDrive)
  private
    Froot: String;
    FAuth : iAuth;

    procedure VerifyToken;
    procedure GetRoot;

    function ExtToContentType(Ext : String): String;
  public
    constructor Create;
    destructor Destroy; override;

    class function New : iDrive;

    function Auth : iAuth;
    function root : String;

    function uploadFile(vFile, FolderId, FileName : String) : String;

    function CreateFolder(vFolderName : String) : String; overload;
    function CreateFolder(vFolderName, ParentId : String) : String; overload;

    function FolderExists(FolderId: String): Boolean;
    function deleteFile(FileId: String) : Boolean;

    procedure DownloadFile(FileId, FileName: String);
  End;

const
  Base_URL = 'https://www.googleapis.com/drive/v3/files';

implementation

uses
  System.Classes, System.SysUtils;

{ TDrive }

function TDrive.Auth: iAuth;
begin
  Result := FAuth;
end;

constructor TDrive.Create;
begin
  FAuth := TAuth.New(Self);
end;

function TDrive.CreateFolder(vFolderName: String): String;
var
  LResponse : IResponse;
begin
  Result := '';

  VerifyToken;

  LResponse := TRequest.New.BaseURL(Base_URL+'?fields=id&key='+FAuth.ApiKey)
    .ContentType('application/json')
    .Token('Bearer '+FAuth.Token)
    .AddBody(
      TJSONObject
      .Create
      .AddPair('name',vFolderName)
      .AddPair('mimeType', 'application/vnd.google-apps.folder')
    )
    .Accept('application/json')
    .Post;

  if LResponse.StatusCode = 200 then
    Result := TJSONObject(LResponse.JSONValue).GetValue<String>('id')
  else
    if (LResponse.StatusCode = 403) then
      begin
        FAuth.TokenRefresh;
        CreateFolder(vFolderName);
      end;
end;

function TDrive.CreateFolder(vFolderName, ParentId: String): String;
var
  LResponse : IResponse;
begin
  VerifyToken;

  Result := CreateFolder(vFolderName);

  LResponse := TRequest.New.BaseURL(Base_URL+'/'+Result+'?addParents=+'+ParentId+'&removeParents='+Froot+'&key='+FAuth.ApiKey)
    .ContentType('application/json')
    .Token('Bearer '+FAuth.Token)
    .Accept('application/json')
    .Patch;

  if LResponse.StatusCode = 200 then
    Result := TJSONObject(LResponse.JSONValue).GetValue<String>('id');
end;

function TDrive.deleteFile(FileId: String): Boolean;
var
  LResponse : IResponse;
begin
  LResponse := TRequest.New.BaseURL(Base_URL+'/'+FileId+'?key='+Fauth.ApiKey)
    .ContentType('application/json')
    .Token('Bearer '+FAuth.Token)
    .Delete;

  Result := (LResponse.StatusCode = 204);

  if not Result then
    if (LResponse.StatusCode = 403) then
      begin
        FAuth.TokenRefresh;
        deleteFile(FileId);
      end;
end;

destructor TDrive.Destroy;
begin

  inherited;
end;

procedure TDrive.DownloadFile(FileId, FileName: String);
var
  LResponse : IResponse;
  MemoryData : TMemoryStream;
begin
  VerifyToken;

  LResponse := TRequest.New.BaseURL(Base_URL + '/' + FileId + '?key='+Fauth.ApiKey+'&alt=media')
    .Token('Bearer '+FAuth.Token)
    .Get;

  if (LResponse.StatusCode = 200) then
    begin
      MemoryData := TMemoryStream.Create;

      try
        MemoryData.LoadFromStream(LResponse.ContentStream);

        MemoryData.SaveToFile(FileName);
      finally
        MemoryData.Free;
      end;
    end;
end;

function TDrive.ExtToContentType(Ext: String): String;
begin
  case AnsiIndexStr(Ext, ['.zip', '.7z','.txt','.jpg','.png','.xml','.pdf','.rtm','.exe']) of
    0 : Result := 'application/zip';
    1 : Result := 'application/zip';
    2 : Result := 'text/plain';
    3 : Result := 'image/jpeg';
    4 : Result := 'image/png';
    5 : Result := 'application/xml';
    6 : Result := 'application/pdf';
    7 : Result := 'text/plain';
    8 : Result := 'application/octet-stream';
  end;
end;

function TDrive.FolderExists(FolderId: String): Boolean;
var
  LResponse : IResponse;
begin
  LResponse := TRequest.New.BaseURL('https://drive.google.com/drive/folders/'+FolderId)
    .ContentType('text/html')
    .Get;

  Result := (LResponse.StatusCode = 200);
end;

procedure TDrive.GetRoot;
var
  LResponse : IResponse;
begin
  LResponse := TRequest.New.BaseURL('https://www.googleapis.com/drive/v2/about?includeSubscribed=true&maxChangeIdCount=10&startChangeId=1&fields=rootFolderId&key='+ FAuth.ApiKey)
    .ContentType('application/json')
    .Token('Bearer '+Auth.Token)
    .Get;

  if (LResponse.StatusCode = 200) then
    Froot := TJSONObject(LResponse.JSONValue).GetValue<String>('rootFolderId')
  else
    if (LResponse.StatusCode = 403) then
      begin
        FAuth.TokenRefresh;
        GetRoot;
      end;
end;

class function TDrive.New: iDrive;
begin
  Result := Self.Create;
end;

function TDrive.root: String;
begin
  Result := Froot;
end;

function TDrive.uploadFile(vFile, FolderId, FileName: String): String;
var
  LResponse     : IResponse;
  upload_stream : TFileStream;
begin
  VerifyToken;

  upload_stream := TFileStream.Create(vFile, fmOpenRead);

  upload_stream.Position := 0;

  LResponse := TRequest.New.BaseURL('https://www.googleapis.com/upload/drive/v2/files?uploadType=media')
    .ContentType(ExtToContentType(ExtractFileExt(vFile)))
    .Token('Bearer '+FAuth.Token)
    .AddBody(upload_stream)
    .Post;

  if (LResponse.StatusCode = 200) then
    begin
      Result := TJSONObject(LResponse.JSONValue).GetValue<String>('id');

      if FolderId = '' then FolderId := Froot;

      LResponse := TRequest.New.BaseURL(Base_URL+'/'+Result+'?addParents=+'+FolderId+'&removeParents='+Froot+'&key='+FAuth.ApiKey)
        .ContentType('application/json')
        .Token('Bearer '+FAuth.Token)
        .AddBody(TJSONObject.Create.AddPair('name', FileName))
        .Accept('application/json')
        .Patch;

      if LResponse.StatusCode = 200 then
        Result := TJSONObject(LResponse.JSONValue).GetValue<String>('id');
    end
  else
    if (LResponse.StatusCode = 403) then
      begin
        FAuth.TokenRefresh;
        uploadFile(vFile, FolderId, FileName);
      end;
end;

procedure TDrive.VerifyToken;
begin
  if FAuth.Token = '' then
    FAuth.TokenRefresh;

  if Froot = '' then GetRoot;
end;

end.
