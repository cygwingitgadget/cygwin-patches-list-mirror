Return-Path: <cygwin-patches-return-3648-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17517 invoked by alias); 28 Feb 2003 06:00:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17508 invoked from network); 28 Feb 2003 06:00:54 -0000
Date: Fri, 28 Feb 2003 06:00:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: access () and path.cc
Message-ID: <20030228060054.GC24690@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030227235437.0080a480@incoming.verizon.net> <3.0.5.32.20030227230453.007d3a60@mail.attbi.com> <3.0.5.32.20030227230453.007d3a60@mail.attbi.com> <3.0.5.32.20030227235437.0080a480@incoming.verizon.net> <3.0.5.32.20030228004959.007ff8b0@incoming.verizon.net> <20030228055635.GB24690@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030228055635.GB24690@redhat.com>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00297.txt.bz2

On Fri, Feb 28, 2003 at 12:56:35AM -0500, Christopher Faylor wrote:
>On Fri, Feb 28, 2003 at 12:49:59AM -0500, Pierre A. Humblet wrote:
>>OK, following Chris' remarks here is a much smaller set
>>of changes.
>
>Do you think it would make sense to do something along the lines
>of:
>
>>+      path_conv pc (cfd->is_device ? cfd->get_name () : cfd->get_win32_name (), PC_SYM_NOFOLLOW);
                       cfd->is_device ()

Btw, thanks much for understanding about this.  I appreciate
that you were trying to fix this the right way the first time.

cgf
