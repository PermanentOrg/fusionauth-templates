[#ftl/]
[#-- @ftlvariable name="application" type="io.fusionauth.domain.Application" --]
[#-- @ftlvariable name="client_id" type="java.lang.String" --]
[#-- @ftlvariable name="method" type="io.fusionauth.domain.TwoFactorMethod" --]
[#-- @ftlvariable name="methodId" type="java.lang.String" --]
[#-- @ftlvariable name="showResendOrSelectMethod" type="boolean" --]
[#-- @ftlvariable name="tenant" type="io.fusionauth.domain.Tenant" --]
[#-- @ftlvariable name="tenantId" type="java.util.UUID" --]
[#-- @ftlvariable name="trustComputer" type="boolean" --]
[#-- @ftlvariable name="twoFactorId" type="java.lang.String" --]
[#-- @ftlvariable name="version" type="java.lang.String" --]
[#import "../_helpers.ftl" as helpers/]

[#assign PERM_DOMAIN="{ENTER DOMAIN HERE}"]

<!doctype html>
<html lang="en">
  [@helpers.permHeadTag title=theme.message('two-factor-challenge')]
    [#-- Custom <head> code goes here --]
    <script src="${request.contextPath}/js/oauth2/TwoFactor.js?version=${version}"></script>
    <script>
      Prime.Document.onReady(function() {
        new FusionAuth.OAuth2.TwoFactor();
      });
    </script>
  [/@helpers.permHeadTag]
  <body class="permanent">
    [@helpers.permHeader /]


    <main>
      <h1 class="form-title">${theme.message('two-factor-challenge')}</h1>

      [#setting url_escaping_charset='UTF-8']
      <form id="2fa-form" action="two-factor" method="POST" class="full">
        [@helpers.prInput type="text" fieldName="code" autocapitalize="none" autocomplete="one-time-code" autocorrect="off" autofocus=true placeholder=theme.message('code')/]

        [@helpers.oauthHiddenFields/]
        [@helpers.hidden name="methodId"/]
        [@helpers.hidden name="twoFactorId"/]
        <div class="form-check">
          <label>
            <input type="checkbox" class="form-check-input" name="trustComputer" [#if trustComputer]checked[/#if]/>
            [#assign trustInDays = (tenant.externalIdentifierConfiguration.twoFactorTrustIdTimeToLiveInSeconds / (24 * 60 * 60))?string("##0")/]
            &nbsp;${theme.message('trust-computer', trustInDays)}
            <i class="fa fa-info-circle" data-tooltip="${theme.message('{tooltip}trustComputer')}"></i>[#t/]
          </label>
        </div>
        <div class="form-row">
          <button type="submit" class="btn btn-primary">${theme.message('verify')}</button>
        </div>

        [#-- If more than one option was available, allow the user to change their mind, or go back and request another code. --]
        [#if showResendOrSelectMethod]
           <div class="form-row mt-4 mb-0" style="text-align: center;">
            [@helpers.link url="/oauth2/two-factor-methods" extraParameters="&twoFactorId=${twoFactorId?url}&methodId=${methodId!''}&selectMethod=true"]
              <i class="fa fa-arrow-left"></i>
              ${theme.message('two-factor-select-method')}
            [/@helpers.link]
           </div>
        [/#if]

      </form>
    </main>
  </body>
</html>
