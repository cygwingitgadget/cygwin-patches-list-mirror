Return-Path: <cygwin-patches-return-3971-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31061 invoked by alias); 18 Jun 2003 09:14:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30996 invoked from network); 18 Jun 2003 09:14:30 -0000
Date: Wed, 18 Jun 2003 09:14:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: getdomainname
Message-ID: <20030618091429.GE10373@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030617220548.00805780@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030617220548.00805780@mail.attbi.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00198.txt.bz2

Hi Pierre,

On Tue, Jun 17, 2003 at 10:05:48PM -0400, Pierre A. Humblet wrote:
> +     FIXME: Are the registry names language dependent?

AFAIK, they aren't.  At least they are the same on my german versions
of 98 and NT4.

> +     FIXME: Handle DHCP on Win95. The DhcpDomain(s) may be available
> +     in ..VxD\DHCP\DhcpInfoXX\OptionInfo, RFC 1533 format */

Yes, it is.  I'm not quite sure what the other values in the OptionInfo
field are.  Weird, though, that `ipconfig /all' still prints the domain
given in MSTCP, even if it's different from the DHCP domain.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
