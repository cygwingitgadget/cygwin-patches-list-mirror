Return-Path: <cygwin-patches-return-3499-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24570 invoked by alias); 5 Feb 2003 16:37:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24557 invoked from network); 5 Feb 2003 16:37:40 -0000
Date: Wed, 05 Feb 2003 16:37:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: sec_acl.cc
Message-ID: <20030205163738.GW5822@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030205102239.00805100@h00207811519c.ne.client2.attbi.com> <3.0.5.32.20030205091505.007fc270@mail.attbi.com> <3.0.5.32.20030205091505.007fc270@mail.attbi.com> <3.0.5.32.20030205102239.00805100@h00207811519c.ne.client2.attbi.com> <3.0.5.32.20030205112940.00804ab0@h00207811519c.ne.client2.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030205112940.00804ab0@h00207811519c.ne.client2.attbi.com>
User-Agent: Mutt/1.4i
X-SW-Source: 2003-q1/txt/msg00148.txt.bz2

On Wed, Feb 05, 2003 at 11:29:40AM -0500, Pierre A. Humblet wrote:
> what good does it do to remove DELETE if unlink() does a
> chmod(777) anyway, which puts it back?

$ touch foo
$ rm foo
$ touch foo
$ chmod u-w foo
$ rm foo
rm: remove write-protected file `foo'? y
$

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
