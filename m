Return-Path: <cygwin-patches-return-3784-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4279 invoked by alias); 2 Apr 2003 23:01:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4240 invoked from network); 2 Apr 2003 23:01:08 -0000
Date: Wed, 02 Apr 2003 23:01:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: cygwin_internal(CW_CHECK_NTSEC, filename) patch
Message-ID: <20030402230108.GC9668@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030402131626.GA1888@tishler.net> <20030402154258.GA2614@redhat.com> <20030402182213.GA3064@tishler.net> <20030402183304.GD3147@redhat.com> <20030402191854.GA532@tishler.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030402191854.GA532@tishler.net>
User-Agent: Mutt/1.4i
X-SW-Source: 2003-q2/txt/msg00011.txt.bz2

On Wed, Apr 02, 2003 at 02:18:54PM -0500, Jason Tishler wrote:
>On Wed, Apr 02, 2003 at 01:33:04PM -0500, Christopher Faylor wrote:
>> If you just do a path_conv on a path, you can check the 'has_acls ()'
>> flag.  I think this just devolves to "allow_ntsec &&
>> win32_path.has_acls ()".
>
>See attached for take 2.

Looks good.  I've applied the patch.

Thanks.

cgf
