Return-Path: <cygwin-patches-return-3785-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 546 invoked by alias); 3 Apr 2003 04:29:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 537 invoked from network); 3 Apr 2003 04:29:10 -0000
Message-Id: <3.0.5.32.20030402232929.007fd540@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net
Date: Thu, 03 Apr 2003 04:29:00 -0000
To: Jason Tishler <jason@tishler.net>,cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: cygwin_internal(CW_CHECK_NTSEC, filename) patch
In-Reply-To: <20030402191854.GA532@tishler.net>
References: <20030402183304.GD3147@redhat.com>
 <20030402131626.GA1888@tishler.net>
 <20030402154258.GA2614@redhat.com>
 <20030402182213.GA3064@tishler.net>
 <20030402183304.GD3147@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q2/txt/msg00012.txt.bz2

At 02:18 PM 4/2/2003 -0500, Jason Tishler wrote:
>On Wed, Apr 02, 2003 at 01:33:04PM -0500, Christopher Faylor wrote:
>> If you just do a path_conv on a path, you can check the 'has_acls ()'
>> flag.  I think this just devolves to "allow_ntsec &&
>> win32_path.has_acls ()".
>
>See attached for take 2.
>
>Thanks,
>Jason

Jason, 

this might return true on Win9X if a user has defined
CYGWIN=ntsec and checks a file mounted on an NT class machine.
You need to add && wincap.has_security().

Also, it's sometimes useful to know the value of allow_ntsec alone.
Could you return that, e.g. if filename is NULL?

Thanks

Pierre
