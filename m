Return-Path: <cygwin-patches-return-3005-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 14301 invoked by alias); 19 Sep 2002 14:46:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14286 invoked from network); 19 Sep 2002 14:46:43 -0000
Message-ID: <3D89E38D.365F3823@ieee.org>
Date: Thu, 19 Sep 2002 07:46:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: More changes about open on Win95 directories.
References: <3.0.5.32.20020918220225.00810100@mail.attbi.com> <3.0.5.32.20020918220225.00810100@mail.attbi.com> <3.0.5.32.20020919001051.008234e0@h00207811519c.ne.client2.attbi.com> <00ed01c25fb7$1f9f6970$0100a8c0@wdg.uk.ibm.com> <20020919142342.GA2293@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q3/txt/msg00453.txt.bz2

Christopher Faylor wrote:
> 
> It really depends on the context.

Some (e.g. fhandler_console) try to cover all bases but 
I don't think it's right, or at least necessary

  HANDLE h = CreateFileA ("CONIN$", GENERIC_READ, FILE_SHARE_WRITE,
  <snip>
  if (h == INVALID_HANDLE_VALUE || h == NULL)

Pierre
