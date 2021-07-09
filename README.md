# GDrive4D
Interface para manipulação de arquivos e pastas no GoogleDrive.

Baseado na documentação:
https://developers.google.com/drive/api/v3/about-sdk

Ative a API para obter as Credenciais de acesso a API.

Para instalar:

```
boss install github.com/WillHubner/GDrive4D
```

Você precisa utilizar GDrive4D

```pascal
uses GDrive4D;
```
* **Autenticação**

```pascal
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
end;
``` 

* **Criar Pasta**

```pascal
begin
  _Drive.CreateFolder('');
end;
``` 

* **Upar Arquivo**

```pascal
begin
  _Drive.uploadFile(DestinoArquivo, ID_Pasta, NomeArquivo)
end;
``` 

* **Deletar Arquivo**

```pascal
begin
  _Drive.deleteFile('')
end;
``` 

* **Download Arquivo**

```pascal
begin
  _Drive.DownloadFile(ID_Arquivo, Destino);
end;
``` 

A requisições foram baseadas na biblioteca **RESTRequest4Delphi** disponível em: 
https://github.com/viniciussanchez/RESTRequest4Delphi 
