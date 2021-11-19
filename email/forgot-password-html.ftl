[#setting url_escaping_charset="UTF-8"]
[#-- The optional 'state' map provided on the Forgot Password API call is exposed in the template as 'state' --]
[#assign domain = "{ENTER DOMAIN HERE}" /]
[#assign url = "https://${domain}/password/change/${changePasswordId}?tenantId=${user.tenantId}" /]
[#list state!{} as key, value][#if key != "tenantId" && value??][#assign url = url + "&" + key?url + "=" + value?url/][/#if][/#list]
<!doctype html>
<html lang="en">
  <head>
    <title>Reset Password on Permanent.org</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style type="text/css">
      * {
        box-sizing: border-box;
      }

      body {
        margin: 0;
        padding: 0;
        -webkit-text-size-adjust: 100%;
        -ms-text-size-adjust: 100%;
        font-family: -apple-system, BlinkMacSystemFont, 'Segoe Ui', Roboto, Helvetica, Arial;
        font-size: 15px;
        background: #f0f0f0;
      }

      table, td {
        border-collapse: collapse;
        mso-table-lspace: 0pt;
        mso-table-rspace: 0pt;
      }

      img {
        border: 0;
        height: auto;
        line-height: 100%;
        outline: none;
        text-decoration: none;
        -ms-interpolation-mode: bicubic;
      }

      p {
        display: block;
        margin: 13px 0;
      }

      .center {
        padding: 13px 0;
        text-align: center;
      }

      .button {
        font-weight: 600;
        border-radius: 20px;
        padding: 10px 15px;
        background: #800080;
        color: #fff;
        text-decoration: none;
      }

      section {
        background-color: #fff;
      }

      .page-section {
        max-width: 600px;
        margin: 0 auto;
        padding: 30px 25px;
      }

      header {
        background: #131b4a;
      }

      .footer {
        font-size: 12px;
        font-style: italic;
      }

      @media only screen and (max-width:480px) {
        @viewport { width:320px; }
        table.full-width-mobile { width: 100% !important; }
        td.full-width-mobile { width: auto !important; }
      }
    </style>
    <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700" rel="stylesheet" type="text/css">
    <style type="text/css">
      @import url(https://fonts.googleapis.com/css?family=Roboto:300,400,500,700);
    </style>
  </head>
  <body>
    <header class="page-section">
      <img src="https://gallery.mailchimp.com/2948a82c4a163d7ab43a13356/images/0418582c-9b36-48b1-9fda-eaa6107c85c9.png" alt="Permanent.org" style="width: 175px; height: 27px" />
    </header>
    <section class="page-section">
      <p>You are receiving this email because you have requested to change your password on Permanent.org. Click the button below to select a new password:</p>
      <div class="center">
        <a href="${url}" class="button">Reset password</a>
      </div>
      <p>Or follow the link below:</p>
      <p class="center">${url}</p>
      <p>This link will expire in 1 hour.</p>
      <p>If you didn’t make this request, ignore this email. If you believe an unauthorized person has accessed your account, please contact us immediately at <a href="mailto:support@permanent.org">support@permanent.org</a> or simply reply to this email. Then, please change your password by signing in at <a href="https://www.permanent.org/app">https://www.permanent.org/app</a>.</p>
      <div class="footer center">
        You are receiving this automated system notification because you are a registered user of Permanent.org.
         You can update your notification preferences in your <a href="https://www.permanent.org/app/(myfiles//dialog:account)">account settings</a>.

         If you believe you are receiving these emails in error or you require further assistance, please contact our Customer Support team at <strong>support@permanent.org</strong> or reply to this email.
      </div>
    </section>
  </body>
</html>
