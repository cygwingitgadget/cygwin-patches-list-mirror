Return-Path: <cygwin-patches-return-3945-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8697 invoked by alias); 9 Jun 2003 17:19:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8654 invoked from network); 9 Jun 2003 17:19:25 -0000
Date: Mon, 09 Jun 2003 17:19:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: exec after seteuid
Message-ID: <20030609171923.GB8870@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030607094044.00805970@mail.attbi.com> <3.0.5.32.20030607153456.008051b0@incoming.verizon.net> <3.0.5.32.20030608173256.007c6d00@incoming.verizon.net> <20030609121132.GJ18350@cygbert.vinschen.de> <3EE48CF9.536E06B5@ieee.org> <20030609145119.GN18350@cygbert.vinschen.de> <3EE4A470.907BE477@ieee.org> <20030609162404.GP18350@cygbert.vinschen.de> <3EE4B921.44DAAC3D@ieee.org> <3EE4BF0D.9050205@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EE4BF0D.9050205@yahoo.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00172.txt.bz2

On Mon, Jun 09, 2003 at 01:08:29PM -0400, Earnie Boyd wrote:
>Pierre A. Humblet wrote:
>>
>>Right. It was a side comment motivated by the presence of the initgroups()
>>in the original BSD login code. I was thinking that one day initgroups on
>>cygwin could do more stuff, allowing for example
>> initgroups("chris", gid)
>> setuid("corinna")
>>which would then have you run with chris' groups. Today the "chris" is
>>disregarded. If initgroups does that, it has to be placed at the right 
>>spot.
>>
>
>Oh, man, I hate it when chris is disregarded, it's disrespectful. ;)

Well, thanks for standing up for me, Earnie!

cgf
