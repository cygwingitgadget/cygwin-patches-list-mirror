Return-Path: <cygwin-patches-return-3087-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 13734 invoked by alias); 25 Oct 2002 19:52:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13648 invoked from network); 25 Oct 2002 19:52:27 -0000
Message-ID: <3DB9A0F8.3080901@yahoo.com>
Date: Fri, 25 Oct 2002 12:52:00 -0000
From: Earnie Boyd <earnie_boyd@yahoo.com>
Reply-To:  cygwin-apps@cygwin.com
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Johnston <paj@pajhome.org.uk>
CC:  cygwin-patches@cygwin.com,  cygwin-apps@cygwin.com
Subject: Re: cygwin-mketc.sh
References: <3DB99F1F.51A3BDD0@pajhome.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q4/txt/msg00038.txt.bz2

Wrong list, redirected.  Please remove cygwin-patches from the 
distribution in response.

Paul Johnston wrote:
> Hi,
> 
> Windows has direct equivalents of some standard unix files: /etc/hosts,
> services, protocols, networks. It is helpful to have symbolic links from
> these files in /etc to the windows equivalents. A few weeks ago we
> talked about this on the main cygwin list. Some of us came up with this
> postinstall script, which has been tested and hardened against windows
> 95/98/ME and NT4/2000/XP (not been tested on NT 3.51). Under NT it works
> with both NTFS and FAT, and it works with strict_case=yes.
> 
> I think it should go in the main cygwin package and install as
> /etc/postinstall/cygwin-mketc.sh
> 
> Paul
