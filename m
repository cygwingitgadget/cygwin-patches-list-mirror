From: Jason Tishler <Jason.Tishler@dothill.com>
To: DJ Delorie <dj@delorie.com>
Cc: cygwin-patches@sourceware.cygnus.com
Subject: Re: [Jason.Tishler@dothill.com: Strange Cygwin 1.1.1 mv Behavior]
Date: Tue, 23 May 2000 13:08:00 -0000
Message-id: <392AE52B.1AF55456@dothill.com>
References: <20000523143453.B22579@cygnus.com> <200005231923.PAA24195@envy.delorie.com>
X-SW-Source: 2000-q2/msg00078.html

DJ,

DJ Delorie wrote:
> Try this, which I'll check in in a moment (i.e. it will be in the next
> snapshot also):

Sorry, I'm not set up to build Cygwin from source so I will have to
wait for the next snapshot.

BTW, I noticed another 1.1.1 HOME directory anomaly:

H:\>set home
HOME=H:\
...

H:\>bash
bash-2.03$ pwd
/home/jt/
        ^
        +--- extra slash

I can work around the above by removing the backslash from HOME:

H:\>set home
HOME=H:
...

H:\>bash
bash-2.03$ pwd
/home/jt

In 1.1.0, I did not get the extra slash:

H:\>set home
HOME=H:\
...

H:\>bash
bash-2.03$ pwd
/home/jt

Jason

-- 
Jason Tishler
Director, Software Engineering       Phone: +1 (732) 264-8770 x235
Dot Hill Systems Corporation         Fax:   +1 (732) 264-8798
82 Bethany Road, Suite 7             Email: Jason.Tishler@dothill.com
Hazlet, NJ 07730 USA                 WWW:   http://www.dothill.com
