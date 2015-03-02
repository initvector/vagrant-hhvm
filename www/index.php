<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>HipHop VM</title>
    </head>
    <body>
        <p>HHVM v<?php echo HHVM_VERSION; ?></p>
        <?php $db = new mysqli('localhost'); ?>

        <?php if (!$db->connect_errno): ?>
        <p>MySQL Server v<?php print_r($db->server_info); ?></p>
        <?php else: ?>
        <p>MySQL Error: <?php echo htmlentities($db->connect_error); ?></p>
        <?php endif; ?>
        <?php $db->close(); ?>

    </body>
</html>

