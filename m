Return-Path: <cygwin-patches-return-3899-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16221 invoked by alias); 26 May 2003 08:11:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16044 invoked from network); 26 May 2003 08:11:42 -0000
Date: Mon, 26 May 2003 08:11:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: df and ls for root directories on Win9X
Message-ID: <20030526081141.GB5976@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030525091901.GA875@cygbert.vinschen.de> <3.0.5.32.20030523183423.008059c0@mail.attbi.com> <20030525091901.GA875@cygbert.vinschen.de> <3.0.5.32.20030525175432.00807100@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030525175432.00807100@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00126.txt.bz2

On Sun, May 25, 2003 at 05:54:32PM -0400, Pierre A. Humblet wrote:
> Meanwhile I found out that my statfs change fixing the MS GetFreeDiskSpace
> bug exposes (on WinME only) a MS GetFreeDiskSpaceEx bug.
> <http://support.microsoft.com/default.aspx?scid=kb%3ben-us%3b314417>  
> 
> Experimentally, that can be fixed by calling GetFreeDiskSpaceEx before
> GetFreeDiskSpace, but not more than once per 3 sec... BTW, looking
> up the disk properties in Windows has the same feature.

Did you actually test that?  The KB article doesn't tell anything about
calling GetFreeDiskSpace after GetFreeDiskSpaceEx fixing the problem.
It just says calling GetFreeDiskSpace instead ofGetFreeDiskSpaceEx is
a possible workaround (very funny).

OTOH, there's a fix for ME available at Micosoft.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
