Return-Path: <cygwin-patches-return-4074-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25962 invoked by alias); 13 Aug 2003 01:55:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25947 invoked from network); 13 Aug 2003 01:55:01 -0000
Message-ID: <3F3999EB.50509@cwilson.fastmail.fm>
Date: Wed, 13 Aug 2003 01:55:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: Questions and a RFC [was Re: Assignment from Nicholas Wourms
 arrived]
References: <20030812191411.GH17051@cygbert.vinschen.de> <3F39704F.6030001@netscape.net>
In-Reply-To: <3F39704F.6030001@netscape.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q3/txt/msg00090.txt.bz2

Nicholas Wourms wrote:

> Planning ahead for future possibilities is always a good thing, so in 
> that respect this seems like a sound idea.  Since we are already dealing 
> with ABI breakage, I thought I'd float this now to see what people 
> think.  Would a change like this be of benefit to Cygwin?

Hell no.  I am irrevocably and unalterably opposed to implementing this 
change before 1.5.2 goes gold.

We've already had THREE ABI breakages in the last month.  Now, you want 
to add another one -- to avoid one in the future.

Here's an idea:  lets wait until the NEXT scheduled ABI breakage to do 
yours; then we'll get two for the price of one.

Right now, cygwin-1.5.x is overdue by several months.  It NEEDS to go 
out the door; we can continually add more ABI breakages forever and 
never release a new version...but that's rather silly IMO.

--
Chuck

