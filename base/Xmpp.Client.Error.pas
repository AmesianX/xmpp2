unit Xmpp.Client.Error;

interface
uses
  Element,XmppUri,SysUtils;
type
  TErrorCondition=(BadRequest,
		Conflict,
		FeatureNotImplemented,
		Forbidden,
		Gone,
		InternalServerError,
		ItemNotFound,
		JidMalformed,
		NotAcceptable,
		NotAllowed,
		NotAuthorized,
		PaymentRequired,
		RecipientUnavailable,
		Redirect,
		RegistrationRequired,
		RemoteServerNotFound,
		RemoteServerTimeout,
		ResourceConstraint,
		ServiceUnavailable,
		SubscriptionRequired,
		UndefinedCondition,
		UnexpectedRequest);
  TErrorType=(ETcancel,
		ETcontinue,
		ETmodify,
		ETauth,
		ETwait);
  TErrorCode=(
  /// <summary>
		/// Bad request
		/// </summary>
		RCBadRequest= 400,
		/// <summary>
		/// Unauthorized
		/// </summary>
		RCUnauthorized			= 401,
		/// <summary>
		/// Payment required
		/// </summary>
		RCPaymentRequired			= 402,
		/// <summary>
		/// Forbidden
		/// </summary>
		RCForbidden				= 403,
		/// <summary>
		/// Not found
		/// </summary>
		RCNotFound				= 404,
		/// <summary>
		/// Not allowed
		/// </summary>
		RCNotAllowed				= 405,
		/// <summary>
		/// Not acceptable
		/// </summary>
		RCNotAcceptable			= 406,
		/// <summary>
		/// Registration required
		/// </summary>
		RCRegistrationRequired	= 407,
		/// <summary>
		/// Request timeout
		/// </summary>
		RCRequestTimeout			= 408,
		/// <summary>
		/// Conflict
		/// </summary>
		RCConflict                = 409,
		/// <summary>
		/// Internal server error
		/// </summary>
		RCInternalServerError		= 500,
		/// <summary>
		/// Not implemented
		/// </summary>
		RCNotImplemented			= 501,
		/// <summary>
		/// Remote server error
		/// </summary>
		RCRemoteServerError		= 502,
		/// <summary>
		/// Service unavailable
		/// </summary>
		RCServiceUnavailable		= 503,
		/// <summary>
		/// Remote server timeout
		/// </summary>
		RCRemoteServerTimeout		= 504,
		/// <summary>
		/// Disconnected
		/// </summary>
		RCDisconnected            = 510
    );
  TError=class(TElement)
  const
    TagName='error';
  private
    procedure FSetMessage(value:string);
    function FGetMessage():string;
    procedure FSetErrorCode(value:TErrorCode);
    function FGetErrorCode():TErrorCode;
    procedure FSetErrorType(value:TErrorType);
    function FGetErrorType():TErrorType;
    procedure FSetCondition(value:TErrorCondition);
    function FGetCondition():TErrorCondition;
  public
    constructor Create();override;
    constructor Create(code:TErrorCode);overload;
    constructor CreateError(tp:TErrorType);
    constructor CreateCondition(condition:TErrorCondition);
    constructor CreateErrorCondition(tp:TErrorType;condition:TErrorCondition);
    property Message:string read FGetMessage write FSetMessage;
    property Code:TErrorCode read FGetErrorCode write FSetErrorCode;
    property ErrorType:TErrorType read FGetErrorType write FSetErrorType;
    property Condition:TErrorCondition read FGetCondition write FSetCondition;
    class function GetConstTagName():string;override;
  end;

implementation

{ TError }

constructor TError.Create(code: TErrorCode);
begin
  Self.Create();
  SetAttribute('code',IntToStr(Integer(code)));
end;

constructor TError.Create();
begin
  inherited Create();
  Name:='error';
  Namespace:=XMLNS_CLIENT;
end;

constructor TError.CreateError(tp: TErrorType);
begin
  self.Create();
  ErrorType:=tp;
end;

constructor TError.CreateErrorCondition(tp: TErrorType;
  condition: TErrorCondition);
begin
  CreateError(tp);
  Condition:=condition;
end;

constructor TError.CreateCondition(condition: TErrorCondition);
begin
  self.Create();
  Condition:=condition;
end;

function TError.FGetCondition: TErrorCondition;
begin
  if (TagExists('bad-request'))	then				// <bad-request/>
					Result:= TErrorCondition.BadRequest
				else if (TagExists('conflict'))then				// <conflict/>
					Result:= TErrorCondition.Conflict
				else if  (TagExists('feature-not-implemented'))then// <feature-not-implemented/>
					Result:= TErrorCondition.FeatureNotImplemented
				else if (TagExists('forbidden'))then				// <forbidden/>
					Result:= TErrorCondition.Forbidden
				else if (TagExists('gone'))	then				// <gone/>
					Result:= TErrorCondition.Gone
				else if (TagExists('internal-server-error'))then		// <internal-server-error/>
					Result:= TErrorCondition.InternalServerError
				else if (TagExists('item-not-found'))then				// <item-not-found/>
					Result:= TErrorCondition.ItemNotFound
				else if (TagExists('jid-malformed'))then				// <jid-malformed/>
					Result:= TErrorCondition.JidMalformed
				else if (TagExists('not-acceptable'))then				// <not-acceptable/>
					Result:= TErrorCondition.NotAcceptable
				else if (TagExists('not-authorized'))then				// <not-authorized/>
					Result:= TErrorCondition.NotAuthorized
				else if (TagExists('payment-required'))then			// <payment-required/>
					Result:= TErrorCondition.PaymentRequired
				else if (TagExists('recipient-unavailable'))then		// <recipient-unavailable/>
					Result:= TErrorCondition.RecipientUnavailable
				else if (TagExists('redirect'))then				// <redirect/>
					Result:= TErrorCondition.Redirect
				else if (TagExists('registration-required'))then		// <registration-required/>
					Result:= TErrorCondition.RegistrationRequired
				else if (TagExists('remote-server-not-found'))then		// <remote-server-not-found/>
					Result:= TErrorCondition.RemoteServerNotFound
				else if (TagExists('remote-server-timeout'))then		// <remote-server-timeout/>
					Result:= TErrorCondition.RemoteServerTimeout
				else if (TagExists('resource-constraint'))then			// <resource-constraint/>
					Result:= TErrorCondition.ResourceConstraint
				else if (TagExists('service-unavailable'))then			// <service-unavailable/>
					Result:= TErrorCondition.ServiceUnavailable
				else if (TagExists('subscription-required'))then		// <subscription-required/>
					Result:= TErrorCondition.SubscriptionRequired
				else if (TagExists('undefined-condition'))then			// <undefined-condition/>
					Result:= TErrorCondition.UndefinedCondition
				else if (TagExists('unexpected-request')) then			// <unexpected-request/>
					Result:= TErrorCondition.UnexpectedRequest
				else
 					Result:= TErrorCondition.UndefinedCondition;
end;

function TError.FGetErrorCode: TErrorCode;
begin
  Result:=TErrorCode(StrToInt(GetAttribute('code')));
end;

function TError.FGetErrorType: TErrorType;
begin
  Result:=TErrorType(StrToInt(GetAttribute('type')));
end;

function TError.FGetMessage: string;
begin
  Result:=data;
end;

procedure TError.FSetCondition(value: TErrorCondition);
begin
  case(value) of
					TErrorCondition.BadRequest:
          begin
						Name:='bad-request';
						ErrorType:= TErrorType.etmodify;
			    end;
					TErrorCondition.Conflict:
          begin
						name:='conflict';
 						ErrorType:= TErrorType.etcancel;
          end;
					TErrorCondition.FeatureNotImplemented:
          begin
						name:='feature-not-implemented';
						ErrorType:= TErrorType.etcancel;
          end;
					TErrorCondition.Forbidden:
          begin
            name:='forbidden';
						ErrorType:= TErrorType.etauth;
          end;
					TErrorCondition.Gone:
          begin
            name:='gone';
						ErrorType:= TErrorType.etmodify;
          end;
					TErrorCondition.InternalServerError:
          begin
          name:='internal-server-error';
						ErrorType:= TErrorType.etwait;
          end;
					TErrorCondition.ItemNotFound:
					begin
            name:='item-not-found';
						ErrorType:= TErrorType.etcancel;
					end;
					TErrorCondition.JidMalformed:
					begin
            name:='jid-malformed';
						ErrorType:= TErrorType.etmodify;
					end;
					TErrorCondition.NotAcceptable:
					begin name:='not-acceptable';
						ErrorType:= TErrorType.etmodify;
						end;
					TErrorCondition.NotAllowed:
					begin name:='not-allowed';
						ErrorType:= TErrorType.etcancel;
						end;
					TErrorCondition.NotAuthorized:
					begin name:='not-authorized';
						ErrorType:= TErrorType.etauth;
						end;
					TErrorCondition.PaymentRequired:
					begin name:='payment-required';
						ErrorType:= TErrorType.etauth;
						end;
					TErrorCondition.RecipientUnavailable:
					begin name:='recipient-unavailable';
						ErrorType:= TErrorType.etwait;
						end;
					TErrorCondition.Redirect:
					begin name:='redirect';
						ErrorType:= TErrorType.etmodify;
						end;
					TErrorCondition.RegistrationRequired:
					begin name:='registration-required';
						ErrorType:= TErrorType.etauth;
						end;
					TErrorCondition.RemoteServerNotFound:
					begin name:='remote-server-not-found';
						ErrorType:= TErrorType.etcancel;
						end;
					TErrorCondition.RemoteServerTimeout:
					begin name:='remote-server-timeout';
						ErrorType:= TErrorType.etwait;
						end;
					TErrorCondition.ResourceConstraint:
					begin name:='resource-constraint';
						ErrorType:= TErrorType.etwait;
						end;
					TErrorCondition.ServiceUnavailable:
					begin name:='service-unavailable';
						ErrorType:= TErrorType.etcancel;
						end;
					TErrorCondition.SubscriptionRequired:
					begin name:='subscription-required';
						ErrorType:= TErrorType.etauth;
						end;
					TErrorCondition.UndefinedCondition:
					begin name:='undefined-condition';
						// could be any
						end;
					TErrorCondition.UnexpectedRequest:
					begin name:='unexpected-request';
						ErrorType:= TErrorType.etwait;
						end;
          end;
end;

procedure TError.FSetErrorCode(value: TErrorCode);
begin
  SetAttribute('code',IntToStr(Integer(value)));
end;

procedure TError.FSetErrorType(value: TErrorType);
begin
  SetAttribute('error',IntToStr(Integer(value)));
end;

procedure TError.FSetMessage(value: string);
begin
  self.value:=value;
end;

class function TError.GetConstTagName: string;
begin
  Result:=TagName+'-';
end;

end.
