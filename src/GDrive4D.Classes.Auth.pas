unit GDrive4D.Classes.Auth;

interface

uses
  RESTRequest4D, System.JSON, GDrive4D.Interfaces;

type
  TAuth = Class(TInterfacedObject, iAuth)
  private
    [weak]
    FParent : iDrive;

    FRefreshToken: String;
    FClientID: String;
    FClientSecret: String;
    FToken: String;
    FApiKey: String;
  public
    constructor Create(Parent : iDrive);
    destructor Destroy; override;

    class function New(Parent : iDrive) : iAuth;

    function RefreshToken(Value : String) : iAuth;
    function ClientID(Value : String) : iAuth;
    function ClientSecret(Value : String) : iAuth;
    function ApiKey(Value : String) : iAuth; overload;
    function ApiKey : String; overload;
    function &End : iDrive;

    function Token : String;
    procedure TokenRefresh;
  end;

implementation

{ TAuth }

function TAuth.ApiKey(Value : String) : iAuth;
begin
  Result := Self;

  FApiKey := Value;
end;

function TAuth.&End: iDrive;
begin
  Result := FParent;
end;

function TAuth.ApiKey: String;
begin
  Result := FApiKey;
end;

function TAuth.ClientID(Value: String): iAuth;
begin
  Result := Self;

  FClientID := Value;
end;

function TAuth.ClientSecret(Value: String): iAuth;
begin
  Result := Self;

  FClientSecret := Value;
end;

constructor TAuth.Create(Parent : iDrive);
begin
  FParent := Parent;
end;

destructor TAuth.Destroy;
begin

  inherited;
end;

class function TAuth.New(Parent : iDrive) : iAuth;
begin
  Result := TAuth.Create(Parent);
end;

function TAuth.RefreshToken(Value: String): iAuth;
begin
  Result := Self;

  FRefreshToken := Value;
end;

function TAuth.Token : String;
begin
  Result := FToken;
end;

procedure TAuth.TokenRefresh;
var
  LResponse : IResponse;
  URLString : String;
begin
  URLString := 'client_id=' + FClientID;
  URLString := URLString + '&client_secret=' + FClientSecret;
  URLString := URLString + '&refresh_token=' + FRefreshToken;
  URLString := URLString + '&grant_type=refresh_token';

  LResponse := TRequest.New.BaseURL('https://accounts.google.com/o/oauth2/token')
    .AddBody(URLString)
    .ContentType('application/x-www-form-urlencoded')
    .Accept('application/json')
    .Post;

  if LResponse.StatusCode = 200 then
    FToken := TJSONObject(LResponse.JSONValue).GetValue<String>('access_token');
end;

end.
