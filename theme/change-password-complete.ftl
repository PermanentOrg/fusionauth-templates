[#ftl/]
[#-- @ftlvariable name="application" type="io.fusionauth.domain.Application" --]
[#-- @ftlvariable name="client_id" type="java.util.UUID" --]
[#-- @ftlvariable name="currentUser" type="io.fusionauth.domain.User" --]
[#-- @ftlvariable name="passwordValidationRules" type="io.fusionauth.domain.PasswordValidationRules" --]
[#-- @ftlvariable name="showCaptcha" type="boolean" --]
[#-- @ftlvariable name="tenant" type="io.fusionauth.domain.Tenant" --]
[#-- @ftlvariable name="tenantId" type="java.util.UUID" --]
[#assign PERM_DOMAIN="{ENTER DOMAIN HERE}"]
[#import "../_helpers.ftl" as helpers/]

<!doctype html>
<html lang="en">
  [@helpers.permHeadTag title="Reset Password" /]
  <body class="permanent">
    [@helpers.permHeader /]
    <main>
      <div class="formstyle">
        <br />
        <p>Your password has been successfully changed.</p>
        <p>You may now log into your account with your new password.</p>
        <a class="btn btn-primary" href="${PERM_DOMAIN}/app/auth/login">
          Log In
        </a>
      </div>
    </main>
  </body>
</html>
