Return-Path: <cygwin-patches-return-3943-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16009 invoked by alias); 9 Jun 2003 17:08:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15964 invoked from network); 9 Jun 2003 17:08:19 -0000
Message-ID: <3EE4BF0D.9050205@yahoo.com>
Date: Mon, 09 Jun 2003 17:08:00 -0000
From: Earnie Boyd <earnie_boyd@yahoo.com>
Reply-To:  cygwin-patches@cygwin.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
CC: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: exec after seteuid
References: <3.0.5.32.20030607153456.008051b0@incoming.verizon.net> <3.0.5.32.20030607094044.00805970@mail.attbi.com> <3.0.5.32.20030607094044.00805970@mail.attbi.com> <3.0.5.32.20030607153456.008051b0@incoming.verizon.net> <3.0.5.32.20030608173256.007c6d00@incoming.verizon.net> <20030609121132.GJ18350@cygbert.vinschen.de> <3EE48CF9.536E06B5@ieee.org> <20030609145119.GN18350@cygbert.vinschen.de> <3EE4A470.907BE477@ieee.org> <20030609162404.GP18350@cygbert.vinschen.de> <3EE4B921.44DAAC3D@ieee.org>
In-Reply-To: <3EE4B921.44DAAC3D@ieee.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q2/txt/msg00170.txt.bz2

Pierre A. Humblet wrote:
> 
> Right. It was a side comment motivated by the presence of the initgroups()
> in the original BSD login code. I was thinking that one day initgroups on
> cygwin could do more stuff, allowing for example
>  initgroups("chris", gid)
>  setuid("corinna")
> which would then have you run with chris' groups. Today the "chris" is
> disregarded. If initgroups does that, it has to be placed at the right spot.
> 

Oh, man, I hate it when chris is disregarded, it's disrespectful. ;)

Sorry, I couldn't resist,
Earnie.
