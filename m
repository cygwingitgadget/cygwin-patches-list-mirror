Return-Path: <cygwin-patches-return-2468-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 7769 invoked by alias); 19 Jun 2002 13:10:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7747 invoked from network); 19 Jun 2002 13:10:38 -0000
Date: Wed, 19 Jun 2002 06:10:00 -0000
From: Jason Tishler <jason@tishler.net>
Subject: Re: Reorganizing internal_getlogin() patch is in
In-reply-to: <3D0F5CB6.58140BD3@ieee.org>
To: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Cc: Corinna Vinschen <cygwin-patches@cygwin.com>
Mail-followup-to: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>,
 Corinna Vinschen <cygwin-patches@cygwin.com>
Message-id: <20020619131159.GF1208@tishler.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.4i
References: <20020616051506.GA6188@redhat.com>
 <20020613052709.GA17779@redhat.com> <20020613052709.GA17779@redhat.com>
 <3.0.5.32.20020616000701.007f7df0@mail.attbi.com>
 <20020616051506.GA6188@redhat.com>
 <3.0.5.32.20020617224247.007faad0@mail.attbi.com>
 <20020618134102.A23980@cygbert.vinschen.de> <3D0F5CB6.58140BD3@ieee.org>
X-SW-Source: 2002-q2/txt/msg00451.txt.bz2

Pierre,

On Tue, Jun 18, 2002 at 12:15:50PM -0400, Pierre A. Humblet wrote:
> Could somebody with only a domain account try the following 
> program? It's quick and dirty, you have to type the logonserver
> and user names in the program. Compile with -lnetapi32 .

I get the following:

    $ ./a
    Server: ret 0
    JATIS
    TISHLER,JASON

    NULL: ret 2221

HTH,
Jason
