Return-Path: <cygwin-patches-return-4185-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9564 invoked by alias); 9 Sep 2003 03:38:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9554 invoked from network); 9 Sep 2003 03:38:15 -0000
Message-ID: <3F5D4A94.1060507@cwilson.fastmail.fm>
Date: Tue, 09 Sep 2003 03:38:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: Fixing a security hole in mount table.
References: <3.0.5.32.20030908204606.00816d10@incoming.verizon.net> <20030909011134.GA6708@redhat.com>
In-Reply-To: <20030909011134.GA6708@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q3/txt/msg00201.txt.bz2

Christopher Faylor wrote:

> I wonder if it is time to bite the bullet and get rid of user-mode
> mounts entirely.  Or maybe disallow them in suid'ed sessions?  They
> are always going to be a security hole AFAICT.

I think that would be a bad idea.  What if I want to install a private 
version of cygwin on a machine to which I don't have Admin access? 
(ITFascists can shut up right now; I'm not listening..."You vill use de 
Microsoft Application Suite ve haf provided, and nuzzing else!")

--
Chuck


