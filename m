Return-Path: <cygwin-patches-return-5427-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27863 invoked by alias); 6 May 2005 14:22:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27689 invoked from network); 6 May 2005 14:22:13 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 6 May 2005 14:22:13 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 449D513C752; Fri,  6 May 2005 10:22:13 -0400 (EDT)
Date: Fri, 06 May 2005 14:22:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: mkdir -p and network drives
Message-ID: <20050506142213.GA20565@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <002f01c5523f$6d6f38b0$3e0010ac@wirelessworld.airvananet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002f01c5523f$6d6f38b0$3e0010ac@wirelessworld.airvananet.com>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q2/txt/msg00023.txt.bz2

On Fri, May 06, 2005 at 09:27:55AM -0400, Pierre A. Humblet wrote:
>cgf wrote:
>> On Thu, May 05, 2005 at 10:57:08PM -0400, Pierre A. Humblet wrote:
>
>>>The code should handle "//" correctly, but path.cc still transforms it
>>>into "/", because of the bash bug.
>
>> Is that fixed in the current bash?
>
>AFAIK Corinna fixed it once, but the patch got lost and it's currently
>not fixed.
>
>> So, I'd appreciate it if you would just move your fhandler_netdrive
>> stuff to fhandler_netdrive.cc.
>
>Sure. Thanks for setting up the framework.
>
>> I didn't renumber FH_FS with above change.  I wasn't sure why you did
>> that.  I don't think that there was a requirement that it has to be the
>> lowest numbered minor device number.  If there is a requirement like
>> that we should change it.
>
>OK. No requirement, just aesthetic. There seemed to be a pattern.
>
>>>About implementing readdir: PTC...
>
>> I was thinking about doing this but how would it ever be invoked?
>
>With "ls -l //"  or "ls -l //machine"
>
>> You can't do an opendir on "//", right?
>
>Sure you can (thanks to existing code in the virtual driver). Just remove
>the
>code in path.cc that changes "//" into "/". It's only/mainly there because
>of bash.

Well, that was kinda my point.  If we can't remove the "//" handling because
it breaks bash then adding opendir/readdir stuff seems premature except for
the case of ls //foo which is entirely different from ls //.

cgf
