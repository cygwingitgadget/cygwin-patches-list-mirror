Return-Path: <cygwin-patches-return-3774-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16661 invoked by alias); 1 Apr 2003 17:05:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16563 invoked from network); 1 Apr 2003 17:05:45 -0000
Date: Tue, 01 Apr 2003 17:05:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: [jeff.rancier@softechnics.com: Re: Problem with gawk (3.1.2-2) under Cygwin 1.3.22-1]
Message-ID: <20030401170540.GE18138@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00001.txt.bz2

----- Forwarded message from "Jeffery B. Rancier" <jeff.rancier@softechnics.com> -----
> Date: Tue, 01 Apr 2003 11:28:05 -0500
> From: jeff.rancier@softechnics.com (Jeffery B. Rancier)
> Subject: Re: Problem with gawk (3.1.2-2) under Cygwin 1.3.22-1
> To: cygwin@cygwin.com
> [...]
> I don't know if this is related, but running 'cygcheck -srv', I get
> the following error:
> 
> cygcheck: dump_sysinfo: GetVolumeInformation() failed: 53
> [...]
----- End forwarded message -----

Hmm, seems we need a test for ERROR_BAD_NETPATH in cygcheck...

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
