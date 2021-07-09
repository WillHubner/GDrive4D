unit GDrive4D;

interface

uses GDrive4D.Interfaces, GDrive4D.Classes.Drive;

type
  IGDrive = GDrive4D.Interfaces.iDrive;

  TGDrive = class
  public
    class function New: IGDrive;
  end;

implementation

{ TGDrive }

class function TGDrive.New: IGDrive;
begin
  Result := GDrive4D.Classes.Drive.TDrive.New;
end;

end.
