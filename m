From: Chris Faylor <cgf@cygnus.com>
To: DJ Delorie <dj@delorie.com>
Cc: cygwin-patches@sources.redhat.com
Subject: Re: [patch] limited /dev/clipboard support
Date: Tue, 17 Oct 2000 09:22:00 -0000
Message-id: <20001017122243.A10031@cygnus.com>
References: <200010170148.VAA15515@envy.delorie.com> <39EBBDDA.99242198@ece.gatech.edu> <200010170248.WAA16051@envy.delorie.com> <20001017112024.A9406@cygnus.com> <200010171532.LAA11734@envy.delorie.com>
X-SW-Source: 2000-q4/msg00009.html

On Tue, Oct 17, 2000 at 11:32:50AM -0400, DJ Delorie wrote:
>
>> Huh?  I just did a cvs update and got fhandler_clipboard.cc with no problems.
>
>What do you have in your .cvsrc for update?

% cat .cvsrc
cvs -q -e /home/cgf/bin/scripts/cvsedit
update -P
checkout -P

cgf
