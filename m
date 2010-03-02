Return-Path: <cygwin-patches-return-6997-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16589 invoked by alias); 2 Mar 2010 16:30:36 -0000
Received: (qmail 16513 invoked by uid 22791); 2 Mar 2010 16:30:33 -0000
X-SWARE-Spam-Status: No, hits=-2.9 required=5.0 	tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from out1.smtp.messagingengine.com (HELO out1.smtp.messagingengine.com) (66.111.4.25)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 02 Mar 2010 16:30:26 +0000
Received: from compute1.internal (compute1 [10.202.2.41]) 	by gateway1.messagingengine.com (Postfix) with ESMTP id 01DEEE2894 	for <cygwin-patches@cygwin.com>; Tue,  2 Mar 2010 11:30:24 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])   by compute1.internal (MEProxy); Tue, 02 Mar 2010 11:30:25 -0500
Received: from [192.168.1.3] (user-0c6sbd2.cable.mindspring.com [24.110.45.162]) 	by mail.messagingengine.com (Postfix) with ESMTPSA id 887AB8C29; 	Tue,  2 Mar 2010 11:30:24 -0500 (EST)
Message-ID: <4B8D3D08.5010400@cwilson.fastmail.fm>
Date: Tue, 02 Mar 2010 16:30:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Add xdr support
References: <4B764A1F.6060003@cwilson.fastmail.fm>  <4B8D2F9D.4090309@cwilson.fastmail.fm> <20100302155305.GA11311@ednor.casa.cgf.cx>
In-Reply-To: <20100302155305.GA11311@ednor.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q1/txt/msg00113.txt.bz2

Christopher Faylor wrote:
> On Tue, Mar 02, 2010 at 10:32:45AM -0500, Charles Wilson wrote:
>> Now, I ran into a small problem: applying the attached patch to current
>> HEAD:
>>
>> or it may be something as simple as, with HEAD, I need to do
>> a complete clean&rebuild.  I'll kick one of those off tonight.
> 
> The snapshot does not display this problem.  It sounds like your
> tlsoffsets.h file is out of date.

Could be -- or that I some stale objects compiled using an out-of-date
tlsoffsets.h file.  Anyway, blowing away my build directory and
rebuilding from scratch, using cvs HEAD + this xdr patch, and everything
is fine. Sorry for the false alarm.

I (again) built the test suite from bsd-xdr so that it uses the xdr
functions exported by the new cygwin1.dll and it passed...


$ xdrmem_test.exe
test_xdrmem_int: PASS
test_xdrmem_u_int: PASS
test_xdrmem_long: PASS
test_xdrmem_u_long: PASS
test_xdrmem_short: PASS
test_xdrmem_u_short: PASS
test_xdrmem_char: PASS
test_xdrmem_u_char: PASS
test_xdrmem_int8_t: PASS
test_xdrmem_u_int8_t: PASS
test_xdrmem_uint8_t: PASS
test_xdrmem_int16_t: PASS
test_xdrmem_u_int16_t: PASS
test_xdrmem_uint16_t: PASS
test_xdrmem_int32_t: PASS
test_xdrmem_u_int32_t: PASS
test_xdrmem_uint32_t: PASS
test_xdrmem_int64_t: PASS
test_xdrmem_u_int64_t: PASS
test_xdrmem_uint64_t: PASS
test_xdrmem_hyper: PASS
test_xdrmem_u_hyper: PASS
test_xdrmem_longlong_t: PASS
test_xdrmem_u_longlong_t: PASS
test_xdrmem_float: PASS
test_xdrmem_double: PASS
test_xdrmem_bool: PASS
test_xdrmem_enum: PASS
test_xdrmem_union: PASS
test_xdrmem_opaque: PASS
test_xdrmem_bytes: PASS
test_xdrmem_string: PASS
test_xdrmem_wrapstring: PASS
test_xdrmem_array: PASS
test_xdrmem_vector: PASS
test_xdrmem_reference: PASS
test_xdrmem_pointer: PASS
test_xdrmem_list: PASS
test_xdrmem_primitive_struct: PASS
All tests passed!


$ xdrstdio_test.exe
test_xdrstdio_int: PASS
test_xdrstdio_u_int: PASS
test_xdrstdio_long: PASS
test_xdrstdio_u_long: PASS
test_xdrstdio_short: PASS
test_xdrstdio_u_short: PASS
test_xdrstdio_char: PASS
test_xdrstdio_u_char: PASS
test_xdrstdio_int8_t: PASS
test_xdrstdio_u_int8_t: PASS
test_xdrstdio_uint8_t: PASS
test_xdrstdio_int16_t: PASS
test_xdrstdio_u_int16_t: PASS
test_xdrstdio_uint16_t: PASS
test_xdrstdio_int32_t: PASS
test_xdrstdio_u_int32_t: PASS
test_xdrstdio_uint32_t: PASS
test_xdrstdio_int64_t: PASS
test_xdrstdio_u_int64_t: PASS
test_xdrstdio_uint64_t: PASS
test_xdrstdio_hyper: PASS
test_xdrstdio_u_hyper: PASS
test_xdrstdio_longlong_t: PASS
test_xdrstdio_u_longlong_t: PASS
test_xdrstdio_float: PASS
test_xdrstdio_double: PASS
test_xdrstdio_bool: PASS
test_xdrstdio_enum: PASS
test_xdrstdio_union: PASS
test_xdrstdio_opaque: PASS
test_xdrstdio_bytes: PASS
test_xdrstdio_string: PASS
test_xdrstdio_wrapstring: PASS
test_xdrstdio_array: PASS
test_xdrstdio_vector: PASS
test_xdrstdio_reference: PASS
test_xdrstdio_pointer: PASS
test_xdrstdio_list: PASS
test_xdrstdio_primitive_struct: PASS
All tests passed!


$ xdrsizeof_test.exe
test_xdrsizeof_list: PASS
test_xdrsizeof_primitive_struct: PASS
All tests passed!


--
Chuck
