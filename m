Return-Path: <cygwin-patches-return-2838-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 22404 invoked by alias); 16 Aug 2002 11:19:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22390 invoked from network); 16 Aug 2002 11:19:23 -0000
Date: Fri, 16 Aug 2002 04:19:00 -0000
From: Jason Tishler <jason@tishler.net>
Subject: Re: [PATCH] check for valid pthread_self pointer
In-reply-to: <Pine.WNT.4.44.0208071245020.353-200000@algeria.intern.net>
To: cygwin-patches@cygwin.com
Mail-followup-to: cygwin-patches@cygwin.com
Message-id: <20020816112218.GA892@tishler.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.4i
References: <Pine.WNT.4.44.0208071245020.353-200000@algeria.intern.net>
X-SW-Source: 2002-q3/txt/msg00286.txt.bz2

Rob,

On Wed, Aug 07, 2002 at 05:19:10PM +0200, Thomas Pfaff wrote:
> This patch should fix the problem with the ipc-daemon started as
> service and threads that are not created by pthread_create.

Please evaluate and commit if OK -- the PostgreSQL folks could really
use this.

Thanks,
Jason
