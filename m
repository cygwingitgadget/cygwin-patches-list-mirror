Return-Path: <cygwin-patches-return-4520-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31075 invoked by alias); 20 Jan 2004 17:22:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31066 invoked from network); 20 Jan 2004 17:22:09 -0000
Date: Tue, 20 Jan 2004 17:22:00 -0000
From: Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
To: cygwin-patches@cygwin.com
Subject: Re: Are cygwin-ug and cygwin-api-int used?
Message-ID: <20040120112212.A23046@ns1.iocc.com>
References: <20040111224520.38647.qmail@web61110.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040111224520.38647.qmail@web61110.mail.yahoo.com>; from joshuadfranklin@yahoo.com on Sun, Jan 11, 2004 at 02:45:20PM -0800
X-SW-Source: 2004-q1/txt/msg00010.txt.bz2

On Sun, Jan 11, 2004 at 02:45:20PM -0800, Joshua Daniel Franklin wrote:
> I would like to remove two build targets from winsup/doc/Makefile.in:
> 
>         cygwin-ug/cygwin-ug.html 
>         cygwin-api-int/cygwin-api-int.html 
> 
> As far as I can tell, these are not used for anything and have
> references to "the GNUPro release". This would not effect the
> "net release" versions of the User's Guide and API Reference:
> 
>         cygwin-ug-net/cygwin-ug-net.html
>         cygwin-api/cygwin-api.html
> 
> I will remove them in a week if no one has any reason not to.
> 

This is now done.
