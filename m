Return-Path: <cygwin-patches-return-2061-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 23340 invoked by alias); 15 Apr 2002 15:31:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23326 invoked from network); 15 Apr 2002 15:31:20 -0000
Message-ID: <3CBAF313.1438CF6C@ieee.org>
Date: Mon, 15 Apr 2002 08:31:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Workaround patch for MS CLOSE_WAIT bug
References: <3.0.5.32.20020414152944.007ec460@mail.attbi.com> <20020415141743.N29277@cygbert.vinschen.de> <20020415150129.GA6372@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q2/txt/msg00045.txt.bz2

Christopher Faylor wrote:
> 
> It looks like the patch will do the job but I would like to be convinced
> that there is no other way around this problem.  If I'm reading this
> correctly, this change requires modifying any code which uses cygwin.
> That's something we should try to avoid at all costs.

I second that 100%. My proposal *allows* porters to avoid CLOSE_WAIT
by making some changes in daemons, but none in the children processes.
No change is required anywhere. The additional Cygwin functionality 
would be invisible to applications that don't explicitly use it.

Pierre
