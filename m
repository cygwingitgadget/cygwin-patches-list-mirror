From: Corinna Vinschen <vinschen@cygnus.com>
To: cygdev <cygwin-developers@sources.redhat.com>, cygpatch <cygwin-patches@sources.redhat.com>
Subject: [PATCH]: variable blocksize for tapes
Date: Sun, 23 Jul 2000 12:45:00 -0000
Message-id: <397B4B56.AAAFD3A4@cygnus.com>
X-SW-Source: 2000-q3/msg00029.html

Hi,

I have checked in a patch to fhandler_dev_raw and fhandler_dev_tape
so that variable blocksize tapes are supported now on tape drives
which support that.

I would be glad if somebody can test it, too. As usual it works
"for me" but there may still be an error or two...

To switch a tape device to variable blocksize, you'll have to
set blocksize to 0. Since this isn't supported by my current
mt version 1.9, I have patched it and copied the new version
1.9.1 to

ftp://sources.redhat.com/pub/cygwin/private/cygwin-extras-392/mt-1.9.1.tar.gz

Thanks in advance,
Corinna

-- 
Corinna Vinschen
Cygwin Developer
Cygnus Solutions, a Red Hat company
