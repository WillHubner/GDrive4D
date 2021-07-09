unit GDrive4D.Interfaces;

interface

type
  iDrive = interface;

  iAuth = interface
    ['{D90D50A4-5377-4006-8397-93DFAAE4970D}']
    function RefreshToken(Value : String) : iAuth;
    function ClientID(Value : String) : iAuth;
    function ClientSecret(Value : String) : iAuth;
    function ApiKey(Value : String) : iAuth; overload;
    function ApiKey : String; overload;
    function &End : iDrive;

    function Token : String;
    procedure TokenRefresh;
  end;

  iDrive = interface
    ['{50C4BFDD-CC5B-484A-A0F2-DE46551C081F}']
    function Auth : iAuth;
    function root : String;

    function uploadFile(vFile, FolderId, FileName : String) : String;

    function CreateFolder(vFolderName : String) : String; overload;
    function CreateFolder(vFolderName, ParentId : String) : String; overload;

    function FolderExists(FolderId: String): Boolean;
    function deleteFile(FileId: String) : Boolean;

    procedure DownloadFile(FileId, FileName: String);
  End;

implementation

end.
