Return-Path: <cygwin-patches-return-3300-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10978 invoked by alias); 10 Dec 2002 14:27:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10969 invoked from network); 10 Dec 2002 14:27:54 -0000
Message-ID: <3DF5FA18.E05B787@ieee.org>
Date: Tue, 10 Dec 2002 06:27:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: Internal get{pw,gr}XX calls
References: <3.0.5.32.20021129005937.00835100@h00207811519c.ne.client2.attbi.com> <3.0.5.32.20021126000911.00833190@mail.attbi.com> <3.0.5.32.20021126000911.00833190@mail.attbi.com> <3.0.5.32.20021129005937.00835100@h00207811519c.ne.client2.attbi.com> <3.0.5.32.20021129131134.00835870@mail.attbi.com> <20021210113437.C7796@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q4/txt/msg00251.txt.bz2

Corinna Vinschen wrote:
> 
> On Fri, Nov 29, 2002 at 01:11:34PM -0500, Pierre A. Humblet wrote:
> > This is from the opengroup:
> > If the correct value is outside the range of representable values,
> > LONG_MAX or LONG_MIN is returned (according to the sign of the value),
> > and errno is set to [ERANGE].
> 
> Pierre, can you give me a link to this info?
> 
http://www.opengroup.org/onlinepubs/007908799/xsh/strtol.html

That's probably moot by now, using strtoul seems to be the way to go. 
I am still surprised that it accepts negative numbers as input.

Pierre
