unit Xmpp.Iq.VcardIq;

interface
uses
  xmpp.client.IQ,xmpp.iq.Vcard,jid,XmppUri;
type
  TVcardIq=class(TIQ)
  private
    procedure FSetVcard(value:TVcard);
    function FGetVcard:TVcard;
  public
    constructor Create();overload;override;
    constructor Create(iqtype:string);overload;
    constructor Create(iqtype:string;vcard:TVcard);overload;
    constructor Create(iqtype:string;tojid:TJID);overload;
    constructor Create(iqtype:string;tojid:TJID;vcard:TVcard);overload;
    constructor Create(iqtype:string;tojid:TJID;fromjid:TJID);overload;
    constructor Create(iqtype:string;tojid:TJID;fromjid:TJID;vcard:TVcard);overload;
    property Vcard:TVcard read FGetVcard write FSetVcard;
    class function GetConstTagName():string;override;
  end;

implementation

{ TVcardIq }

constructor TVcardIq.Create( iqtype: string; vcard: TVcard);
begin
  Self.Create(iqtype);
  self.Vcard:=vcard;
end;

constructor TVcardIq.Create(iqtype: string);
begin
  Self.Create();
  self.iqtype:=iqtype
end;

constructor TVcardIq.Create();
var
_vcard:TVcard;
begin
  inherited;
  _vcard:=TVcard.Create();
  GenerateId;
  FSetQuery(_vcard);
end;

constructor TVcardIq.Create(iqtype: string; tojid: TJID);
begin
  Self.Create(iqtype);
  Self.ToJid:=tojid;
end;

constructor TVcardIq.Create(iqtype: string; tojid,
  fromjid: TJID; vcard: TVcard);
begin
  Self.Create(iqtype,tojid,fromjid);
  self.Vcard:=vcard;
end;

constructor TVcardIq.Create(iqtype: string; tojid,
  fromjid: TJID);
begin
  Self.Create(iqtype);
  Self.ToJid:=tojid;
  Self.fromjid:=fromjid;

end;

constructor TVcardIq.Create(iqtype: string; tojid: TJID;
  vcard: TVcard);
begin
  Self.Create(iqtype,tojid);
  self.Vcard:=vcard;
end;

function TVcardIq.FGetVcard: TVcard;
begin
  Result:=TVcard(getfirsttag('vCard'));
end;
procedure TVcardIq.FSetVcard(value: TVcard);
begin
  ReplaceNode(value);
end;
class function TVcardIq.GetConstTagName: string;
begin
Result:=TagName+'-'+XMLNS_VCARD;
end;
end.
