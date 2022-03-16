[#ftl/]
[#setting url_escaping_charset="UTF-8"]
[#-- @ftlvariable name="application" type="io.fusionauth.domain.Application" --]
[#-- @ftlvariable name="client_id" type="java.lang.String" --]
[#-- @ftlvariable name="code_challenge" type="java.lang.String" --]
[#-- @ftlvariable name="code_challenge_method" type="java.lang.String" --]
[#-- @ftlvariable name="devicePendingIdPLink" type="io.fusionauth.domain.provider.PendingIdPLink" --]
[#-- @ftlvariable name="hasDomainBasedIdentityProviders" type="boolean" --]
[#-- @ftlvariable name="identityProviders" type="java.util.Map<java.lang.String, java.util.List<io.fusionauth.domain.provider.BaseIdentityProvider<?>>>" --]
[#-- @ftlvariable name="loginId" type="java.lang.String" --]
[#-- @ftlvariable name="metaData" type="io.fusionauth.domain.jwt.RefreshToken.MetaData" --]
[#-- @ftlvariable name="nonce" type="java.lang.String" --]
[#-- @ftlvariable name="passwordlessEnabled" type="boolean" --]
[#-- @ftlvariable name="pendingIdPLink" type="io.fusionauth.domain.provider.PendingIdPLink" --]
[#-- @ftlvariable name="redirect_uri" type="java.lang.String" --]
[#-- @ftlvariable name="rememberDevice" type="boolean" --]
[#-- @ftlvariable name="response_type" type="java.lang.String" --]
[#-- @ftlvariable name="scope" type="java.lang.String" --]
[#-- @ftlvariable name="showCaptcha" type="boolean" --]
[#-- @ftlvariable name="showPasswordField" type="boolean" --]
[#-- @ftlvariable name="state" type="java.lang.String" --]
[#-- @ftlvariable name="tenant" type="io.fusionauth.domain.Tenant" --]
[#-- @ftlvariable name="tenantId" type="java.util.UUID" --]
[#-- @ftlvariable name="timezone" type="java.lang.String" --]
[#-- @ftlvariable name="user_code" type="java.lang.String" --]
[#-- @ftlvariable name="version" type="java.lang.String" --]
[#import "../_helpers.ftl" as helpers/]
[#assign PERM_DOMAIN="{ENTER DOMAIN HERE}"]

<!doctype html>
<html lang="en">
    [@helpers.permHeadTag title="Reset Password"]
      <script src="/js/jstz-min-1.0.6.js"></script>
      [@helpers.captchaScripts showCaptcha=showCaptcha captchaMethod=tenant.captchaConfiguration.captchaMethod siteKey=tenant.captchaConfiguration.siteKey/]
      <script src="/js/oauth2/Authorize.js?version=${version}"></script>
      <script src="/js/identityProvider/InProgress.js?version=${version}"></script>
      [@helpers.alternativeLoginsScript clientId=client_id identityProviders=identityProviders/]
      <script>
        Prime.Document.onReady(function() {
          [#-- This object handles guessing the timezone and filling in the device id of the user --]
          new FusionAuth.OAuth2.Authorize();
        });
      </script>
    [/@helpers.permHeadTag]

  <body class="permanent">
    [@helpers.permHeader /]
    <main>
      [#-- During a linking work flow, optionally indicate to the user which IdP is being linked. --]
      [#if devicePendingIdPLink?? || pendingIdPLink??]
        <p class="mt-0">
        [#if devicePendingIdPLink?? && pendingIdPLink??]
          ${theme.message('pending-links-login-to-complete', devicePendingIdPLink.identityProviderName, pendingIdPLink.identityProviderName)}
        [#elseif devicePendingIdPLink??]
          ${theme.message('pending-link-login-to-complete', devicePendingIdPLink.identityProviderName)}
        [#else]
          ${theme.message('pending-link-login-to-complete', pendingIdPLink.identityProviderName)}
        [/#if]
        [#-- A pending link can be cancled. If we also have a device link in progress, this cannot be canceled. --]
        [#if pendingIdPLink??]
          [@helpers.link url="" extraParameters="&cancelPendingIdpLink=true"]${theme.message('login-cancel-link')}[/@helpers.link]
        [/#if]
        </p>
      [/#if]
      <form action="${request.contextPath}/oauth2/authorize" method="POST" class="full">
        <h1 class="form-title">Authorize Application</h1>
        [@helpers.oauthHiddenFields/]
        [@helpers.hidden name="showPasswordField"/]
        [#if showPasswordField && hasDomainBasedIdentityProviders]
          [@helpers.hidden name="loginId"/]
        [/#if]

        [@helpers.prInput type="text" fieldName="loginId" autocomplete="username" placeholder=theme.message('loginId') autofocus=true required=true disabled=(showPasswordField && hasDomainBasedIdentityProviders) /]
        [#if showPasswordField]
          [@helpers.prInput type="password" fieldName="password" autocomplete="current-password" autofocus=loginId?has_content placeholder=theme.message('password') /]
          <!-- [@helpers.captchaBadge showCaptcha=showCaptcha captchaMethod=tenant.captchaConfiguration.captchaMethod siteKey=tenant.captchaConfiguration.siteKey/] -->
        [/#if]

        <div class="form-check">
          [@helpers.prCheckbox fieldName="rememberDevice" label=theme.message('remember-device') value="true" uncheckedValue="false"]
            <i class="fa fa-info-circle" data-tooltip="${theme.message('{tooltip}remember-device')}"></i>[#t/]
          [/@helpers.prCheckbox]
        </div>

          <div class="form-row">
            [#if showPasswordField]
              <button type="submit" class="btn btn-primary">${theme.message('submit')}</button>
              <br />
              <div style="text-align: center">
                [@helpers.link url="${request.contextPath}/password/forgot"]${theme.message('forgot-your-password')}[/@helpers.link]
              </div>
            [#else]
              <button type="submit" class="btn btn-primary">${theme.message('next')}</button>
            [/#if]
          </div>
      </form>
      <div style="text-align: center">
        [#if showPasswordField && hasDomainBasedIdentityProviders]
          [@helpers.link url="" extraParameters="&showPasswordField=false"]${theme.message('sign-in-as-different-user')}[/@helpers.link]
        [/#if]
      </div>
      [#if application.registrationConfiguration.enabled]
        <div class="form-row push-top">
          ${theme.message('dont-have-an-account')}
          [@helpers.link url="${request.contextPath}/oauth2/register"]${theme.message('create-an-account')}[/@helpers.link]
        </div>
      [/#if]
      [@helpers.alternativeLogins clientId=client_id identityProviders=identityProviders passwordlessEnabled=passwordlessEnabled/]
    </main>
  </body>
</html>
