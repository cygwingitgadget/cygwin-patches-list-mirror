Return-Path: <cygwin-patches-return-2441-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 19426 invoked by alias); 16 Jun 2002 05:21:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19404 invoked from network); 16 Jun 2002 05:21:03 -0000
Date: Sat, 15 Jun 2002 22:21:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Reorganizing internal_getlogin() patch is in
Message-ID: <20020616052136.GA7708@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20020613052709.GA17779@redhat.com> <20020613052709.GA17779@redhat.com> <3.0.5.32.20020616000701.007f7df0@mail.attbi.com> <20020616051506.GA6188@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020616051506.GA6188@redhat.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00424.txt.bz2

On Sun, Jun 16, 2002 at 01:15:06AM -0400, Christopher Faylor wrote:
>>In env_userprofile () I don't understand why the last two conditions
>>are useful in:
>>  if (strcasematch (name (), "SYSTEM") || !env_domain () || !env_logsrv ())
>>The domain should never be NULL, and the logserver only NULL for SYSTEM.
>
>The domain can be NULL if LookupAccountSid fails.  get_logon_server can
>fail, also.  Certainly it makes sense to fail gracefully, no?

Nevermind.  I realized what you meant 2 seconds after hitting 'y'.  I'll nuke
these tests.

cgf
