Return-Path: <cygwin-patches-return-5158-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25372 invoked by alias); 22 Nov 2004 16:01:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25274 invoked from network); 22 Nov 2004 16:00:59 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 22 Nov 2004 16:00:59 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id C91AA1B3E5; Mon, 22 Nov 2004 11:01:42 -0500 (EST)
Date: Mon, 22 Nov 2004 16:01:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com, pierre.humblet@ieee.org
Subject: Re: [Patch] Loading the registry hive on Win9x (part 2)
Message-ID: <20041122160142.GB31237@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com, pierre.humblet@ieee.org
References: <3.0.5.32.20041121215538.008217f0@incoming.verizon.net> <20041122152518.GD25781@trixie.casa.cgf.cx> <41A20A4E.C4A20EC6@phumblet.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41A20A4E.C4A20EC6@phumblet.no-ip.org>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00159.txt.bz2

On Mon, Nov 22, 2004 at 10:48:30AM -0500, Pierre A. Humblet wrote:
>Christopher Faylor wrote:
>> 
>> On Sun, Nov 21, 2004 at 09:55:38PM -0500, Pierre A. Humblet wrote:
>> >-  got_something_from_registry = regopt ("default");
>> >   if (myself->progname[0])
>> >-    got_something_from_registry = regopt (myself->progname) || got_something_from_registry;
>> >+    got_something_from_registry = regopt (myself->progname);
>> >+  got_something_from_registry =  got_something_from_registry || regopt ("default");
>> 
>> Doesn't this change the sense of the "default" key so that it will never
>> get used if a key exists for myself->progname rather than always get
>> used, regardless?  Maybe I'm the only person in the world who relies on
>> that behavior, but I do rely on it.
>
>Hmm, I thought that what went on before was that the "default"
>key was always read, but that it was overwritten if the other key
>existed. Is it the case that there is no complete overwriting,
>it's the union that counts? If so, I will put it back that way.

AFAICT, regopt calls parse_options which parses the options immediately.
So, the first call to "default" sets the CYGWIN environment variable
options from the registry immediately.

>I didn't know that every program was trying to read 4 items in the
>registry. Wouldn't it make sense to keep inheritable keys to the Cygwin
>registry branches on the cygheap, instead of walking down the hierarchy
>four times?

What kind of speed improvement would we see from this?  AFAIK, windows
programs read the registry all of the time.

>By the way, perhaps others in the world would also find that feature
>useful, but AFAIK it's a well kept secret. FAQ or users' guide alert?

It's user's guide fodder.

cgf
