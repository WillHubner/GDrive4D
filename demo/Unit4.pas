unit Unit4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, GDrive4D;

type
  TForm4 = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Memo1: TMemo;
    Panel7: TPanel;
    Button2: TButton;
    Button1: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    OpenDialog1: TOpenDialog;
    Button7: TButton;
    SaveDialog1: TSaveDialog;
    Panel2: TPanel;
    Label2: TLabel;
    edClientID: TEdit;
    Panel3: TPanel;
    Label3: TLabel;
    edClientSecret: TEdit;
    Panel5: TPanel;
    Label5: TLabel;
    edRefreshToken: TEdit;
    Panel6: TPanel;
    Label6: TLabel;
    edAPIKEY: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
  private
    { Private declarations }
    _Drive : IGDrive;
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

procedure TForm4.Button1Click(Sender: TObject);
begin
  _Drive :=
    TGDrive
      .New
      .Auth
        .RefreshToken(edRefreshToken.Text)
        .ClientID(edClientID.Text)
        .ApiKey(edAPIKEY.Text)
        .ClientSecret(edClientSecret.Text)
        .&End;

  Button2.Enabled := True;
  Button3.Enabled := True;
  Button4.Enabled := True;
  Button5.Enabled := True;
  Button6.Enabled := True;
  Button7.Enabled := True;
end;

procedure TForm4.Button2Click(Sender: TObject);
begin
  Memo1.Text := _Drive.CreateFolder('');
end;

procedure TForm4.Button3Click(Sender: TObject);
begin
  Memo1.Text := _Drive.CreateFolder('','');
end;

procedure TForm4.Button4Click(Sender: TObject);
begin
  if _Drive.FolderExists('') then
    Memo1.Lines.Add('Existe')
  else
    Memo1.Lines.Add('Não existe');
end;

procedure TForm4.Button5Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    Memo1.Lines.Add(_Drive.uploadFile(OpenDialog1.FileName, '', ExtractFileName(OpenDialog1.FileName)));
end;

procedure TForm4.Button6Click(Sender: TObject);
begin
  if _Drive.deleteFile('') then
    Memo1.Lines.Add('Arquivo deletado');
end;

procedure TForm4.Button7Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
    _Drive.DownloadFile('', SaveDialog1.FileName);
end;

end.
