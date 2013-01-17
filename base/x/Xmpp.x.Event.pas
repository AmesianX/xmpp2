unit Xmpp.x.Event;

interface
uses
  Element,XmppUri;
type
  TEvent=class(TElement)
  const
  TagName='x';
  private
    function FGetOffline:Boolean;
    procedure FSetOffline(value:Boolean);
    function FGetDelivered:Boolean;
    procedure FSetDelivered(value:Boolean);
    function FGetDisplay:Boolean;
    procedure FSetDisplay(value:Boolean);
    function FGetComposing:Boolean;
    procedure FSetComposing(value:Boolean);
    function FGetId:string;
    procedure FSetId(value:string);
  public
    constructor Create();override;
    property Offline:Boolean read FGetOffline write FSetOffline;
    property Delivered:Boolean read FGetDelivered write FSetDelivered;
    property Displayed:Boolean read FGetDisplay write FSetDisplay;
    property Composing:Boolean read FGetComposing write FSetComposing;
    property Id:string read FGetId write FSetId;
    class function GetConstTagName():string;override;
  end;

implementation

{ TEvent }

constructor TEvent.Create();
begin
  inherited Create();
  Name:='x';
  Namespace:=XMLNS_X_EVENT;
end;

function TEvent.FGetComposing: Boolean;
begin
  Result:=HasTag('composing');
end;

function TEvent.FGetDelivered: Boolean;
begin
  Result:=HasTag('delivered');
end;

function TEvent.FGetDisplay: Boolean;
begin
  Result:=HasTag('displayed');
end;

function TEvent.FGetId: string;
begin
  Result:=GetTag('id');
end;

function TEvent.FGetOffline: Boolean;
begin
  Result:=HasTag('offline');
end;

procedure TEvent.FSetComposing(value: Boolean);
begin
  RemoveTag('composing');
  if value then
    AddTag(TElement.Create('composing'));
end;

procedure TEvent.FSetDelivered(value: Boolean);
begin
  RemoveTag('delivered');
  if value then
    AddTag(TElement.Create('delivered'));
end;

procedure TEvent.FSetDisplay(value: Boolean);
begin
  RemoveTag('displayed');
  if value then
    AddTag(TElement.Create('displayed'));
end;

procedure TEvent.FSetId(value: string);
begin
  SetTag('id',value);
end;

procedure TEvent.FSetOffline(value: Boolean);
begin
  RemoveTag('offline');
  if value then
    AddTag(TElement.Create('offline'));
end;

class function TEvent.GetConstTagName: string;
begin
Result:=TagName+'-'+XMLNS_X_EVENT;
end;

end.
