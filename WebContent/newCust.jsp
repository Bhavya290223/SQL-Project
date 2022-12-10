<!DOCTYPE html>
<html>
<head>
<title>Create Account Page</title>
</head>
<body>
<h1>Add New Account</h1>
<br>

<form name="MyForm" method=post action="checkNewCust.jsp">
    <table style="display:inline">
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Enter First Name:</font></div></td>
        <td><input type="text" name="fname"  size=10 maxlength=40></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Enter Last Name:</font></div></td>
        <td><input type="text" name="lname"  size=10 maxlength=40></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Enter Email:</font></div></td>
        <td><input type="email" name="email"  size=10 maxlength=50></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Enter Phone Number:</font></div></td>
        <td><input type="text" name="num" size=10 maxlength="20"></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Enter Address:</font></div></td>
        <td><input type="text" name="address"  size=10 maxlength=50></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Enter City:</font></div></td>
        <td><input type="text" name="city"  size=10 maxlength=40></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Enter State:</font></div></td>
        <td><input type="text" name="state"  size=10 maxlength=20></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Enter Postal Code:</font></div></td>
        <td><input type="text" name="psc"  size=10 maxlength=20></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Enter Country:</font></div></td>
        <td><input type="text" name="country"  size=10 maxlength=40></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Set Username:</font></div></td>
        <td><input type="text" name="user"  size=10 maxlength=20></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Set Password:</font></div></td>
        <td><input type="text" name="pass"  size=10 maxlength=30></td>
    </tr>
    </table>
    <br/>
    <input class="submit" type="submit" name="Submit2" value="Create!">
</form>

</body>
</html>
