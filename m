Return-Path: <cygwin-patches-return-3699-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10758 invoked by alias); 12 Mar 2003 12:17:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10725 invoked from network); 12 Mar 2003 12:17:57 -0000
Message-ID: <3E6F25C3.2060503@yahoo.com>
Date: Wed, 12 Mar 2003 12:17:00 -0000
From: Earnie Boyd <earnie_boyd@yahoo.com>
Reply-To:  cygwin-patches@cygwin.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: fhandler_socket::dup
References: <3E6DF617.CA7DC2C0@ieee.org> <3.0.5.32.20030310200902.007f3100@mail.attbi.com> <20030311102431.GB13544@cygbert.vinschen.de> <3E6DF617.CA7DC2C0@ieee.org> <3.0.5.32.20030312001525.007f5310@incoming.verizon.net> <20030312055720.GB10425@redhat.com>
In-Reply-To: <20030312055720.GB10425@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q1/txt/msg00348.txt.bz2

Christopher Faylor wrote:
> On Wed, Mar 12, 2003 at 12:15:25AM -0500, Pierre A. Humblet wrote:
> 
>>At 04:20 PM 3/11/2003 +0100, Corinna Vinschen wrote:
>>
>>
>>>>>I'm seriously concidering to remove all the fixup_before/fixup_after
>>>>>from fhandler_socket::dup() and just call fhandler_base::dup() on
>>>>>NT systems.
>>
>>Corinna,
>>
>>I like that and I have pushed the logic to also do it on Win9X, without
>>apparent bad effects. I just delivered 140 e-mails from a WinME to an exim 
>>server on Win98, ran inetd, ssh, etc... I also tried duping a socket after a 
>>fork, it worked fine.
> 
> 
> I think it doesn't work fine on Windows 95, IIRC.
> 

How many w95 environments with Cygwin are being used?  Are they involved 
with support at least to the point of testing it and providing feedback 
with debugging information?  I've come to the attitude that if a 
hobbyist isn't willing to test proposed releases and help debug them to 
keep his system compatible, then he can just live with not upgrading and 
I'll remove all support in following releases.

Earnie.

P.S. CGF, we have a mutual friend that does.  If you can't figure out 
who just ask me privately.
