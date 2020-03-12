<html>

  <style>
    /* defines the fonts type and size for text in the HTML body */
    body {
      font-family: Arial;
    	font-size: 12pt;
    }
    input[type=button], input[type=submit], input[type=reset] {
      background-color: #4CAF50;
      border: none;
      color: white;
      padding: 10px 20px;
      text-decoration: none;
      font-size: 15pt;
      font-weight: bold;
      margin: 4px 2px;
      cursor: pointer;
      border-radius: 4px;
    }
    /* define table to use full width of page, will resize with browser page*/
  	.cacheTable{
  		width:100%;
  		border-collapse:collapse;
  	}
  	.cacheTable td{
  	   padding:7px; border:#4e95f2 1px solid;
  	}
  	/* define background color for odd rows */
  	.cacheTable tr:nth-child(odd){
  		background: #b8d1f4;
  	}
  	/*  define background color for even rows  */
  	.cacheTable tr:nth-child(even){
  		background: #dae5f1;
  	}
  </style>

<body>

  <%@ page language="java"
    import="com.tangosol.net.CoherenceSession,
    com.tangosol.net.NamedCache,
    com.tangosol.net.Session,
    java.util.Collection"
  %>

  <h1>Cache Entries</h1>

  <!-- define user table with column labels -->
  <table class="cacheTable" id="cacheTable"  border="1" cellpadding="2">
    <tr>
      <td><b>Key</b></td>
      <td><b>Value</b></td>

  <%

    // Grab the variables from the form.
    String formKey = request.getParameter("key");
    String formValue = request.getParameter("val");

    Session coh_session = new CoherenceSession();
    NamedCache <Object, Object> cache = coh_session.getCache("demo");

    cache.put(formKey, formValue);

    Collection<Object> keys = cache.keySet();

    for ( Object key : keys ) {
      Object oValue = cache.get(key);
      String value = oValue.toString();
      String cacheKey = key.toString();

      if ( value == null ) {
        out.println(">>>>NULL:");
      }
      else {

  %>

    <tr>
      <td><%=cacheKey %></td>
      <td><%=value %></td>
    </tr>

  <%
      }
    }

    coh_session.close();
  %>

  </table>

  <br><br>

    <form action="cachemap.html" method="post">
      <input type="submit" value="Return" /></form>

</body>
</html>
