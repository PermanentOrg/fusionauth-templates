[#ftl/]
[#-- @ftlvariable name="tenant" type="io.fusionauth.domain.Tenant" --]
[#-- @ftlvariable name="tenantId" type="java.util.UUID" --]
[#import "_helpers.ftl" as helpers/]

<!doctype html>
<html>
  [@helpers.permHeadTag title="Permanent.org - FusionAuth"/]
  <body class="permanent">
    [@helpers.permHeader showAdminLock=true/]

    <main style="text-align: center;">
      <h1>Welcome!</h1>
      <p>The Permanent web application can be found on <a href="https://permanent.org/app">Permanent.org</a></p>
      [#-- Maybe put a link to account self service here? --]
    </main>

    [#if tenantId == "0d4161cf-c520-e5fa-9250-e23ba0e3e6a3" ]
      [#-- Using an HTML comment so this is visible in the rendered HTML. We don't want to freak anyone out. --]
      <!-- Feel free to remove this, it is just a stupid easter egg. Enjoy. -->
      <!--   "Escape is impossible when you're caught in the net" https://www.imdb.com/title/tt0113957/  -->
      <div style="position:fixed; left:0; bottom: 0; margin-bottom: 7px; margin-left: 10px;"><a style="color: #eee;" href="https://the-praetorians.net" title="Escape is impossible when you're caught in the net.">π</a></div>
    [/#if]
  </body>
</html>
