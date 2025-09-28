library Project1;

uses
  Web.WebReq,
  Web.WebBroker,
  Web.Win.ISAPIApp,
  WebModuleUnit1 in 'WebModuleUnit1.pas' {WebModule1: TWebModule};

exports
  GetExtensionVersion,
  HttpExtensionProc,
  TerminateExtension;

begin
  Application.Initialize;
  Application.WebModuleClass := TWebModule1;
  Application.Run;
end.
