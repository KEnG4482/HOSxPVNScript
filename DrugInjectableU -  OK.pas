unit DrugInjectableU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinBlueprint,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinTheAsphaltWorld,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue, cxGroupBox, ExtCtrls, dxGDIPlusClasses, JvExControls,
  JvNavigationPane, Menus, StdCtrls, cxButtons, DB, DBClient, cxStyles,
  dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxNavigator, cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, jpeg, JvgGroupBox,
  RzPanel, RzLabel, cxTextEdit, cxMemo, ComCtrls, cxCheckBox, MemDS, DBAccess,
  MyAccess;

type
  TDrugInjectableFrm = class(TForm)
    JvNavPanelHeader1: TJvNavPanelHeader;
    JvNavPanelHeader2: TJvNavPanelHeader;
    GroupBox2: TGroupBox;
    JvNavPanelHeader3: TJvNavPanelHeader;
    StatusBar1: TStatusBar;
    cxButton1: TcxButton;
    cxButton3: TcxButton;
    Label3: TLabel;
    Timer1: TTimer;
    Image1: TImage;
    cxButton2: TcxButton;
    procedure cxButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cxButton4Click(Sender: TObject);
    procedure cxCheckBox1Click(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DrugInjectableFrm: TDrugInjectableFrm;
   fhn,fip,nemo_url,fcid,fname,fline_token,fcard,fserver,flogint,fdepart,fvn: string;

implementation

{$R *.dfm}

procedure TDrugInjectableFrm.cxButton1Click(Sender: TObject);
var
fvn,fip,fhn,nemo_url,fcid,furl,fline_token, fuser,fname,flogint,fdepart,fserver,fcard, fhospcode, txt_sql, fdate_now, a1: string;
   var count_cid,i : integer;
begin
// NemoCare;
   fvn:= Getglobalvalue('VN');
   fcid:= getsqldata('select convert(hex(encode(p.cid,"nemocarethailand")) using tis620) cid from ovst o left outer join patient p on p.hn=o.hn where '+
' ((cid) is null or LENGTH((cid)) <> 13 or (SUBSTR((cid) FROM 1 FOR 1) = "0" or '+
' Right(11-((Left((cid),1)*13)+(Mid((cid),2,1)*12)+(Mid((cid),3,1)*11)+(Mid((cid),4,1)*10)+ '+
' (Mid((cid),5,1)*9)+(Mid((cid),6,1)*8)+(Mid((cid),7,1)*7)+(Mid((cid),8,1)*6)+(Mid((cid),9,1)*5)+ '+
' (Mid((cid),10,1)*4)+(Mid((cid),11,1)*3)+(Mid((cid),12,1)*2)) Mod 11,1) <> Right((cid),1)))=0 '+
' and o.vn="'+fvn+'" ');

 if fcid <> '' then begin
  //nemo_url:='"http://pnphos.net/nemocare_v2/modules/emr/emr_opd_hosxp.php?CID='+fcid+'"';
  nemo_url:=fcid;
   //Log insert
   fhn:=getsqldata('select hn from ovst where vn = "'+fvn+'"');
  fuser := getsqldata('select kskloginname from onlineuser where onlineid = "'+get_onlineid+'"') ;
  fip := getsqldata('select computername from onlineuser where onlineid = "'+get_onlineid+'"') ;
  fname := getsqldata('select opd.name from onlineuser ou left outer join opduser opd on opd.loginname=ou.kskloginname where onlineid = "'+get_onlineid+'"') ;
  fdepart := getsqldata('select department from onlineuser where onlineid = "'+get_onlineid+'"') ;
  fline_token := getsqldata('select line_token from onlineuser o left outer join opduser u on u.loginname=o.kskloginname where onlineid = "'+get_onlineid+'"') ;
  fserver := getsqldata('select servername from onlineuser where onlineid = "'+get_onlineid+'"') ;
   flogint := getsqldata('select ksklogintime from onlineuser where onlineid = "'+get_onlineid+'"') ;
  fcard := getsqldata('select d.cid from opduser o left outer join doctor d on d.code=o.doctorcode LEFT OUTER JOIN onlineuser u on u.kskloginname=o.loginname   where onlineid = "'+get_onlineid+'" GROUP BY d.cid   ') ;
  fhospcode := getsqldata('select hospitalcode from opdconfig limit 1') ;
  fdate_now := getsqldata('select DATE_FORMAT(now(),"%Y%m%d%H%i%s")') ;
   //showmessage(fdate_now);


  txt_sql := '(\'''+fhospcode+'\'',\'''+fuser+'\'',\'''+fcid+'\'',\'''+fdate_now+'\'')';


if (MessageDlg('Your Username&Password ?',mtConfirmation,[mbYes,mbNo],0)=mrYes) then
   begin


 hosxp_getdataset('insert into nemo.nemo_his_view_emr(hospcode,hn,vn,cid,cardid,computer,ip,login_name,doctor_name,d_update)  '+
   'values('''+fhospcode+''','''+fhn+''','''+fvn+''','''+fcid+''','''+fcard+''','''+fserver+''','''+fip+''','''+fuser+''','''+fname+''','''+fdate_now+''')');

//  winexec('C:\Program Files (x86)\Google\Chrome\Application\chrome.exe '+nemo_url);
  winexec('cmd /c start https://www.nemocare.net/nemocare_v2/modules/emr/emr.php?CID='+nemo_url);

  end;
 end;

  if fcid = '' then  begin

    showmessage('CID');
    end;

end;

procedure TDrugInjectableFrm.cxButton2Click(Sender: TObject);
begin
  winexec('GTWMali.exe'+''+fhn);
end;

procedure TDrugInjectableFrm.cxButton3Click(Sender: TObject);
begin
  RunHOSxP_ScriptProgram('Covid19_Vaccine');
end;

procedure TDrugInjectableFrm.cxButton4Click(Sender: TObject);
begin
    close;
end;

procedure TDrugInjectableFrm.cxCheckBox1Click(Sender: TObject);
begin
   if cxcheckbox1.Checked=true then
   begin
     cxbutton4.Enabled:=true;
   end
    else
     cxbutton4.Enabled:=false;
     end;


procedure TDrugInjectableFrm.FormCreate(Sender: TObject);
var
fvn,fcid: string;
  i:integer;
begin
  //
   fvn := GetGlobalValue('VN');
    fhn := GetSQLdata('select hn from ovst where vn = "'+fvn+'"');
    fcid:=getsqldata('select cid from patient where hn="'+fhn+'" ');
      //
    nemo_url:=fcid;
    //

//    label1.caption:=fhn;
    Label3.caption:=getsqldata('select concat(pname,fname," ",lname)as name from patient where hn= "'+fhn+'"') ;
//    Label6.caption:=getsqldata('select cid from patient where hn= "'+fhn+'"') ;
//    Label8.caption:=getsqldata('SELECT concat  '+
//     '(addrpart,''หมู่'', moopart, full_name ) as address FROM patient p '+
//     'LEFT OUTER JOIN thaiaddress t ON t.addressid=concat(p.chwpart,p.amppart,p.tmbpart) where hn= "'+fhn+'"') ;
//
//      drug_cds.data:=hosxp_getdataset('select concat(h.name,''จ.'',h.province_name)as hospital_take,w.rxtime,w.vstdate,w.rxdate, '+
//      'concat(w.drug_name,''  '',w.strength,''  '',''('',w.units,'')'')as drug, '+
//      'w.drug_use,w.qty,w.last_edit,convert(decode(unhex(w.cid),"nemocarethailand") using tis620) as cidd from hos.vn_stat v '+
//      ' join nemo.sync_warfarin_cid_detail w on v.cid=convert(decode(unhex(w.cid),"nemocarethailand") using tis620) '+
//      ' join hos.hospcode  h on h.hospcode=w.hospcode where v.vn= "'+fvn+'" ORDER BY w.rxdate desc ');



end;

procedure TDrugInjectableFrm.Timer1Timer(Sender: TObject);
begin
 close;
end;

end.
