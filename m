Return-Path: <cygwin-patches-return-3156-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31100 invoked by alias); 12 Nov 2002 16:32:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31054 invoked from network); 12 Nov 2002 16:31:56 -0000
Date: Tue, 12 Nov 2002 08:32:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: patch 3: sshd
Message-ID: <20021112173154.H10395@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q4/txt/msg00107.txt.bz2

On Wed, 06 Nov 2002 11:36:31 -0500, Pierre A. Humblet wrote:
> Currently setuid on Win95/98/ME always returns success
> but does not change the uid. That confuses some programs
> that verify if the setuid has really succeeded.
> 
> It is literally a two line change in Cygwin to fix
> that, but unfortunately changing uids breaks sshd
> on Win95/98/ME.

Can we really do this?  Doesn't that potentially break something?

> P.S.: There is an opposite problem in login. It doesn't
> check if the setuid succeeds. If it fails (e.g. because
> the sid is missing in /etc/passwd), login goes ahead
> and starts the shell anyway. The user then finds herself
> running as SYSTEM.

Thanks, I'm going to apply a patch.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
