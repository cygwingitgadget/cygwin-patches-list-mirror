Return-Path: <cygwin-patches-return-4736-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30787 invoked by alias); 9 May 2004 14:37:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30777 invoked from network); 9 May 2004 14:37:17 -0000
Date: Sun, 09 May 2004 14:37:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: env -i
Message-ID: <20040509003858.GA30449@coe.bosbc.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040508144526.0080bdb0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040508144526.0080bdb0@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q2/txt/msg00088.txt.bz2

On Sat, May 08, 2004 at 02:45:26PM -0400, Pierre A. Humblet wrote:
>Before:
>~: env -i /bin/env
>HOMEDRIVE=C:
>HOMEPATH=\Documents and Settings\Owner
>LOGONSERVER=\\COMPAQ
>SYSTEMDRIVE=C:
>SYSTEMROOT=C:\WINDOWS
>USERDOMAIN=COMPAQ
>USERNAME=Owner
>USERPROFILE=C:\Documents and Settings\Owner
>
>After:
>~: env -i /bin/env
>~: 
>(but the variables are present with telnet, ssh, etc..)
>
>Pierre
>
>2004-05-08  Pierre Humblet <pierre.humblet@ieee.org>
>
>	* environ.cc (build_env): Only try to construct required-but-missing
>	variables while issetuid.

Ok with me.  Wasn't this your addition to begin with?

cgf
