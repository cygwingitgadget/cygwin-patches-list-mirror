Return-Path: <cygwin-patches-return-3972-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3463 invoked by alias); 18 Jun 2003 13:20:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3394 invoked from network); 18 Jun 2003 13:20:41 -0000
Message-ID: <3EF067A7.C4975A9B@ieee.org>
Date: Wed, 18 Jun 2003 13:20:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: getdomainname
References: <3.0.5.32.20030617220548.00805780@mail.attbi.com> <20030618091429.GE10373@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q2/txt/msg00199.txt.bz2

Corinna Vinschen wrote:
> 
> Hi Pierre,
> 
> On Tue, Jun 17, 2003 at 10:05:48PM -0400, Pierre A. Humblet wrote:
> > +     FIXME: Are the registry names language dependent?
> 
> AFAIK, they aren't.  At least they are the same on my german versions
> of 98 and NT4.

OK, I will delete that comment.

> > +     FIXME: Handle DHCP on Win95. The DhcpDomain(s) may be available
> > +     in ..VxD\DHCP\DhcpInfoXX\OptionInfo, RFC 1533 format */
> 
> Yes, it is.  I'm not quite sure what the other values in the OptionInfo
> field are.  

I have figured them out, but that's not the end of the story. 
I don't know how to map the XX in DhcpInfoXX to a specific interface, 
and I don't know how to determine if the interface is up. 
Once that is figured out, there is another weird hex value in DhcpInfoXX 
in which the lease times are imbedded, in seconds since 1980, 
with a 1 hour offset that I can't account for.
Considering that all of this only matters on Win95 running DHCP,
I will let it simmer on my backburner.

> Weird, though, that `ipconfig /all' still prints the domain
> given in MSTCP, even if it's different from the DHCP domain.

Yes, the locally configured domain takes precedence over the DHCP
domain. I have not figured out what happens when DHCP is running
on several interfaces, providing different domain names on each.  

Pierre
