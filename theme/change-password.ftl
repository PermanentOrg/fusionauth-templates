[#ftl/]
[#-- @ftlvariable name="application" type="io.fusionauth.domain.Application" --]
[#-- @ftlvariable name="client_id" type="java.util.UUID" --]
[#-- @ftlvariable name="currentUser" type="io.fusionauth.domain.User" --]
[#-- @ftlvariable name="passwordValidationRules" type="io.fusionauth.domain.PasswordValidationRules" --]
[#-- @ftlvariable name="showCaptcha" type="boolean" --]
[#-- @ftlvariable name="tenant" type="io.fusionauth.domain.Tenant" --]
[#-- @ftlvariable name="tenantId" type="java.util.UUID" --]
[#import "../_helpers.ftl" as helpers/]
[#assign PERM_DOMAIN="{ENTER DOMAIN HERE}"]

<!doctype html>
<html lang="en">
  [@helpers.permHeadTag title="Reset Password" /]
  <body class="permanent">
    [@helpers.permHeader /]
    <main>
      <form action="${request.contextPath}/password/change" method="POST" class="full">
        [@helpers.oauthHiddenFields/]
        [@helpers.hidden name="changePasswordId"/]
        <h1 class="form-title">Password Reset</h1>
        <p>Enter the new password for your account.</p>
        [#-- Show the Password Validation Rules if there is a field error for 'password' --]
        [#if (fieldMessages?keys?seq_contains("password")!false) && passwordValidationRules??]
          <div style="color: red;">[@helpers.passwordRules passwordValidationRules/]</div>
        [/#if]
        <div class="input-group-vertical">
          [@helpers.prInput type="password" fieldName="password" autocomplete="new-password" placeholder=theme.message('password') autofocus=true required=true/]
          [@helpers.prInput type="password" fieldName="passwordConfirm" autocomplete="new-password" placeholder=theme.message('passwordConfirm')  required=true/]
        </div>
        <button type="submit" class="btn btn-primary">Change password</button>
        <a href="${PERM_DOMAIN}/app/auth/signup">
          Need to sign up?
        </a>
        <br />
        <a href="${PERM_DOMAIN}/app/auth/login">
          Want to log in?
        </a>
      </form>
    </main>
  </body>
</html>
