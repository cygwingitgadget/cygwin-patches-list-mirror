Return-Path: <cygwin-patches-return-4896-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9590 invoked by alias); 14 Aug 2004 14:36:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9580 invoked from network); 14 Aug 2004 14:36:37 -0000
Message-ID: <01C4821C.DCA0AFF0.Gerd.Spalink@t-online.de>
From: Gerd.Spalink@t-online.de (Gerd Spalink)
Reply-To: "Gerd.Spalink@t-online.de" <Gerd.Spalink@t-online.de>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: RE: [Patch]: fhandler_dsp.cc
Date: Sat, 14 Aug 2004 14:36:00 -0000
Organization: privat
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-ID: EwMVfZZYweRirHTbIWQnnhqoD0WGfhOe0-CZVwFQNiCB3KMuXdKKo0
X-SW-Source: 2004-q3/txt/msg00048.txt.bz2

Hello,

After some busy weeks with no spare time for cygwin and before leaving for 
two weeks of summer vacation, I looked briefly at your patch.

Your patch looks quite good. But I used two queues for a purpose:
isr2app: buffers that have been Prepared and must be Unprepared before use
app2app: buffers that are ready for use

So I am afraid that in 
fhandler_dev_dsp::Audio_out::sendcurrent
the error handling is functionally not the same:
If PrepareHeader has been successful, then (and only then)
the driver must do UnprepareHeader for this header.
This requirement is from the win32 API.
And if PrepareHeader goes wrong, our driver should not lose that buffer.
After your patch, headers that have not been "Prepared" might get
"Unprepared" (if PrepareHeader fails).

I hope the GETOSPACE ioctl still yields the correct result.

I could not test your patch.

There is one FIXME comment if the error handling (failure to queue a
buffer to wave device) should be the same for audio_in and audio_out.
It is important not to lose any wave headers, otherwise the number
of useful buffers decreases after such an error.

For audio_in, buffers without data are queued to the device, after
having been filled with recorded audio, the device ISR queues the "full"
buffer in isr2app. In case of error we could queue to isr2app, but the
dwBytesRecorded field would have to be set to zero because otherwise
the driver would assume recorded audio in here. Currently, there is no
error handling in this case.

It is good to hear that you are using the test suite for verification.
Has my patch to the test suite been applied? I added a quite nasty test
for dup.

Gerd

On Saturday, August 14, 2004 5:49 AM, Pierre A. Humblet [SMTP:pierre@phumblet.no-ip.org] wrote:
> This patch to fhandler_dsp.cc fixes all issues with dup and 
> redirection, using archetypes. 
> It also takes care of not freezing Win9X (that was a real pain
> to debug). 
> It passes the testsuite (slightly modified, patch coming), 
> as well as all my tests. 
> 
> The logic of the interface to Windows audio is unchanged.
> 
> The ChangeLog is long because the code is organized as
> many small functions, and they needed small changes.
> I hope Gerd will be able to take a look.
> 
> Pierre
> 
> 2004-08-14  Pierre Humblet <pierre.humblet@ieee.org>
> 
> 	* fhandler.h (fhandler_dev_dsp:~fhandler_dev_dsp): Delete.
> 	(fhandler_dev_dsp::open_count): Delete.		   
> 	(fhandler_dev_dsp::close_audio_in): New method declaration.
> 	(fhandler_dev_dsp::close_audio_in): Ditto.
> 	* fhandler_dsp.cc: Add and edit debug_printf throughout.
> 	(fhandler_dev_dsp::Audio::denyAccess): Delete.
> 	(fhandler_dev_dsp::Audio::fork_fixup): Ditto.
> 	(fhandler_dev_dsp::Audio::getOwner): Ditto.
> 	(fhandler_dev_dsp::Audio::clearOwner): Ditto.
> 	(fhandler_dev_dsp::Audio::owner_): Ditto.
> 	(fhandler_dev_dsp::Audio::setformat): Ditto, rename to setconvert.
> 	(fhandler_dev_dsp::Audio::lock): Ditto, move to queue.
> 	(fhandler_dev_dsp::Audio::unlock): Ditto.
> 	(fhandler_dev_dsp::Audio::lock_): Ditto.
> 	(fhandler_dev_dsp::Audio::bufferIndex_): New member, from Audio_out
> 	and Audio_in.
> 	(fhandler_dev_dsp::Audio::pHdr_): Ditto.
> 	(fhandler_dev_dsp::Audio::wavehdr_): Ditto.
> 	(fhandler_dev_dsp::Audio::bigwavebuffer_): ditto.
> 	(fhandler_dev_dsp::Audio::Qisr2app_): Ditto.
> 	(fhandler_dev_dsp::Audio::setconvert): New method, from old setformat.
> 	(fhandler_dev_dsp::Audio::queue::lock): New method.
> 	(fhandler_dev_dsp::Audio::queue::unlock): Ditto.
> 	(fhandler_dev_dsp::Audio::queue::dellock): Ditto.
> 	(fhandler_dev_dsp::Audio::queue::isvalid): Ditto.
> 	(fhandler_dev_dsp::Audio::queue::lock_): New member.
> 	(fhandler_dev_dsp::Audio::queue::depth1_): Delete.
> 	(fhandler_dev_dsp::Audio_out::fork_fixup): New method.
> 	(fhandler_dev_dsp::Audio_out::isvalid): New method.
> 	(fhandler_dev_dsp::Audio_out::start): Remove arguments.
> 	(fhandler_dev_dsp::Audio_out::parsewav): Change arguments and set 
> 	internal state.
> 	(fhandler_dev_dsp::Audio_out::emptyblocks): Delete.
> 	(fhandler_dev_dsp::Audio_out::Qapp2app_): Ditto.
> 	(fhandler_dev_dsp::Audio_out::Qisr2app_): Ditto, move to Audio.
> 	(fhandler_dev_dsp::Audio_out::bufferIndex_): Ditto.
> 	(fhandler_dev_dsp::Audio_out::pHdr_): Ditto.
> 	(fhandler_dev_dsp::Audio_out::wavehdr_): Ditto.
> 	(fhandler_dev_dsp::Audio_out::bigwavefuffer_): Ditto.
> 	(fhandler_dev_dsp::Audio_out::freq_): New member.
> 	(fhandler_dev_dsp::Audio_out::bits_): New member.
> 	(fhandler_dev_dsp::Audio_out::channels_): New member.
> 	(fhandler_dev_dsp::Audio_in::fork_fixup): New method.
> 	(fhandler_dev_dsp::Audio_in::isvalid): New method.
> 	(fhandler_dev_dsp::Audio_in::Qapp2app_): Delete.
> 	(fhandler_dev_dsp::Audio_in::Qisr2app_): Ditto, move to Audio.
> 	(fhandler_dev_dsp::Audio_in::bufferIndex_): Ditto.
> 	(fhandler_dev_dsp::Audio_in::pHdr_): Ditto.
> 	(fhandler_dev_dsp::Audio_in::wavehdr_): Ditto.
> 	(fhandler_dev_dsp::Audio_in::bigwavefuffer_): Ditto.
> 	(fhandler_dev_dsp::Audio::queue::queue): Simplify.
> 	(fhandler_dev_dsp::Audio::queue::send): Use lock.
> 	(fhandler_dev_dsp::Audio::queue::query): Do not use depth1_.
> 	(fhandler_dev_dsp::Audio::queue::recv): Ditto.
> 	(fhandler_dev_dsp::Audio::Audio): Adapt to new class members.
> 	(fhandler_dev_dsp::Audio::~Audio): Ditto
> 	(fhandler_dev_dsp::Audio_out::start): Reorganize.
> 	(fhandler_dev_dsp::Audio_out::stop): Simplify.
> 	(fhandler_dev_dsp::Audio_out::init): Reset the queue and clear flag.
> 	(fhandler_dev_dsp::Audio_out::write): Reorganize to allocate audio_out.
> 	(fhandler_dev_dsp::Audio_out::buf_info): Use appropriate block size.
> 	(fhandler_dev_dsp::Audio_out::callback_sampledone): Do not use lock.
> 	(fhandler_dev_dsp::Audio_out::waitforspace): Simplify.
> 	(fhandler_dev_dsp::Audio_out::waitforallsent):Ditto.
> 	(fhandler_dev_dsp::Audio_out::sendcurrent): Reorganize.
> 	(fhandler_dev_dsp::Audio_out::parsewav): 
> 	(fhandler_dev_dsp::Audio_in::start): Reorganize.
> 	(fhandler_dev_dsp::Audio_in::stop): Simplify.
> 	(fhandler_dev_dsp::Audio_in::queueblock): Ditto.
> 	(fhandler_dev_dsp::Audio_in::init): Reset the queue and clear flag.
> 	(fhandler_dev_dsp::Audio_in::waitfordata): Simplify. 
> 	(fhandler_dev_dsp::Audio_in::buf_info): Ditto.
> 	(fhandler_dev_dsp::Audio_in::callback_blockfull): Do not use lock.
> 	(fhandler_dev_dsp::open_count): Delete.
> 	(fhandler_dev_dsp::open): Only check existence, do not allocate
> 	anything. Set flags appropriately. Create archetype.
> 	(fhandler_dev_dsp::write): Call archetype as needed. Create audio_out.
> 	(fhandler_dev_dsp::read): Call archetype as needed. Create audio_in.
> 	(fhandler_dev_dsp::close): Call archetype as needed. 
> 	Call close_audio_in and close_audio_out.
> 	(fhandler_dev_dsp::close_audio_in): New function.
> 	(fhandler_dev_dsp::close_audio_out): New function.
> 	(fhandler_dev_dsp::dup): Use archetypes.
> 	(fhandler_dev_dsp::ioctl): Call archetype as needed. Reorganize for
> 	new structures.
> 	(fhandler_dev_dsp::fixup_after_fork): Call archetype as needed.
> 	(fhandler_dev_dsp::fixup_after_exec): Call archetype as needed.
> 	Clear audio_in and audio_out.
>  << File: dsp.txt >> 
