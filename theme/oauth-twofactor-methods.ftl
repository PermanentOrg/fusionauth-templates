[#ftl/]
[#-- @ftlvariable name="application" type="io.fusionauth.domain.Application" --]
[#-- @ftlvariable name="availableMethodsMap" type="java.util.Map<java.lang.String, io.fusionauth.domain.TwoFactorMethod>" --]
[#-- @ftlvariable name="client_id" type="java.lang.String" --]
[#-- @ftlvariable name="methodId" type="java.lang.String" --]
[#-- @ftlvariable name="recoverCodesAvailable" type="int" --]
[#-- @ftlvariable name="tenant" type="io.fusionauth.domain.Tenant" --]
[#-- @ftlvariable name="tenantId" type="java.util.UUID" --]
[#-- @ftlvariable name="twoFactorId" type="java.lang.String" --]
[#-- @ftlvariable name="version" type="java.lang.String" --]
[#import "../_helpers.ftl" as helpers/]

[#macro methodOption id method]
 <div class="form-row" >
   <label>
     <input type="radio" name="methodId" value="${id}" [#if id = methodId!'']checked[/#if]>
     [#if method.method == "email"]
       <span>Email message</span>
       <span>
        [#assign index = method.email?index_of("@")/]
        Get a code at ${method.email?substring(0, index + 2)}&hellip;
       </span>
     [#elseif method.method == "authenticator"]
       &nbsp;<span>Authenticator</span>
        <span>
         Get a code from your authenticator app
        </span>
     [#elseif method.method == "sms"]
        <span>Text message</span>
        <span>
         Get a code at (***) ***-**${method.mobilePhone?substring(method.mobilePhone?length - 2)}
        </span>
     [#else]
        ${theme.optionalMessage(method.method)}
     [/#if]
     </label>
 </div>
[/#macro]

[#macro recoveryCodeOption]
<div class="form-row">
  <label>
    <input type="radio" name="methodId" value="recoveryCode" [#if "recoveryCode" == methodId!'']checked[/#if]>
       <span>${theme.message('two-factor-recovery-code')}</span>
       <span>
         ${theme.message('two-factor-use-one-of-n-recover-codes', recoverCodesAvailable)}
       </span>
  </label>
</div>
[/#macro]

<!doctype html>
<html>
  [@helpers.permHeadTag title=theme.message('two-factor-challenge-options')]
    [#-- Custom <head> code goes here --]
    <style>
      .radio-items .form-row label {
        border-left: 2px solid transparent;
        font-weight: 500;
        padding-bottom: 15px;
        padding-left: 0px;
        padding-top: 5px;
      }

      .radio-items .form-row label span:first-of-type {
        margin-left: 5px;
      }

      .radio-items .form-row label span:last-of-type {
        border-top: 1px solid #d2d2d2;
        display: block;
        font-size: 12px;
        font-weight: 400;
        margin-left: 34px;
        margin-top: 2px;
        padding-top:2px;
      }
    </style>
  [/@helpers.permHeadTag]
  <body class="permanent">
    [@helpers.permHeader /]

    <main>
      <h1 class="form-title">${theme.message('two-factor-challenge-options')}</h1>
      [#setting url_escaping_charset='UTF-8']
      <form id="2fa-form" action="two-factor-methods" method="POST" class="full">

        [@helpers.oauthHiddenFields/]
        [@helpers.hidden name="twoFactorId"/]

        [#-- Panel description --]
        ${theme.message('{description}two-factor-methods-selection')}

        [#-- Available methods --]
        <div class="mt-3 hover radio-items">

          [#list availableMethodsMap as id, method]
             [@methodOption id method/]
          [/#list]

          [#-- Optionally show an option for recovery codes. A recovery code can always be used to login, so selecting this is not
               required to allow the user to enter a recovery code. But it is a cue to the user that they have this option.
               Feel free to remove it if you do not want to show it, it will not affect the user's ability to use a recovery code.
           --]
          [#if recoverCodesAvailable gt 0]
            [@recoveryCodeOption/]
          [/#if]

          [#-- Show the methodId error here sinc we will have more than one radio button. This can be moved to suit you. --]
          [@helpers.errors "methodId"/]
        </div>

        [#-- Continue to the next step to enter your code. --]
        <button type="submit" class="btn btn-primary">
          ${theme.message('continue')}
        </button>
      </form>
    </main>
  </body>
</html>
