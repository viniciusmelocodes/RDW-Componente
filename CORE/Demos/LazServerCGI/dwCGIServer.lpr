program dwCGIServer;

{$mode objfpc}{$H+}

{$DEFINE APACHE}


uses
  fpCGI, fpHTTP, HTTPDefs,
  {$IFNDEF APACHE}
  fpWeb, fpHTTPApp, uConsts,
  {$ENDIF}
  dmdwcgiserver, uDmService;

begin
  {$IFNDEF APACHE}
   Application.Port:= serverPort;
  {$ENDIF}
  Application.CreateForm(TdwCGIService, dwCGIService);
  Application.Initialize;
  Application.Run;
end.

