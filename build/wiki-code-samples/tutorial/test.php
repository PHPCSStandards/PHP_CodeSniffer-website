<?php

// Slash comments should be ignored.

/* Star comments should also be ignored. */

# Hash comments should be flagged.
if ($obj->contentsAreValid($array)) {
    $value = $obj->getValue();

    # Value needs to be an array.
    if (is_array($value) === false) {
        # Error.
        $obj->throwError();
        exit();
    }
}
