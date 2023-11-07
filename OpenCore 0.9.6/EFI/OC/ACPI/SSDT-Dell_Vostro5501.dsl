DefinitionBlock ("", "SSDT", 2, "Hack", "HackLife", 0x00000000)
{
    External (_SB_.AC__, DeviceObj)
    External (_SB_.ACOS, IntObj)
    External (_SB_.ACSE, IntObj)
    External (_SB_.PCI0, DeviceObj)
    External (_SB_.PCI0.GFX0, DeviceObj)
    External (_SB_.PCI0.I2C1, DeviceObj)
    External (_SB_.PCI0.I2C1.TPD0, DeviceObj)
    External (_SB_.PCI0.LPCB, DeviceObj)
    External (_SB_.PCI0.LPCB.PS2K, DeviceObj)
    External (_SB_.PCI0.RP05.PXSX._OFF, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.RP08, DeviceObj)
    External (_SB_.PCI0.RP08.PXSX, DeviceObj)
    External (_SB_.PCI0.RP09, DeviceObj)
    External (_SB_.PCI0.RP09.PXSX, DeviceObj)
    External (_SB_.PCI0.RP13, DeviceObj)
    External (_SB_.PCI0.RP13.PXSX, DeviceObj)
    External (_SB_.PR00, ProcessorObj)
    External (HPTE, IntObj)
    External (SSD1, IntObj)
    External (SSH1, IntObj)
    External (SSL1, IntObj)
    External (STAS, FieldUnitObj)
    External (TPDM, IntObj)
    External (XPRW, MethodObj)    // 2 Arguments

    Scope (\)
    {
        If (_OSI ("Darwin"))
        {
            \_SB.ACOS = 0x80
            \_SB.ACSE = Zero
            HPTE = Zero
            STAS = One
            TPDM = Zero
        }

        Scope (_GPE)
        {
            If (_OSI ("Darwin"))
            {
                Method (LXEN, 0, NotSerialized)
                {
                    Debug = "Method \\_GPE.LXEN Called"
                    Return (One)
                }
            }
        }

        Scope (_SB)
        {
            Scope (AC)
            {
                If (_OSI ("Darwin"))
                {
                    Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
                    {
                        0x16, 
                        0x03
                    })
                }
            }

            If (_OSI ("Darwin"))
            {
                Device (DGPU)
                {
                    Name (_HID, "DGPU1000")  // _HID: Hardware ID
                    Method (_INI, 0, NotSerialized)  // _INI: Initialize
                    {
                        \_SB.PCI0.RP05.PXSX._OFF ()
                    }
                }
            }

            Scope (PCI0)
            {
                Scope (GFX0)
                {
                    Device (PNLF)
                    {
                        Name (_HID, EisaId ("APP0002"))  // _HID: Hardware ID
                        Name (_CID, "backlight")  // _CID: Compatible ID
                        Name (_UID, 0x13)  // _UID: Unique ID
                        Method (_STA, 0, NotSerialized)  // _STA: Status
                        {
                            If (_OSI ("Darwin"))
                            {
                                Return (0x0B)
                            }
                            Else
                            {
                                Return (Zero)
                            }
                        }
                    }
                }

                Scope (I2C1)
                {
                    If (_OSI ("Darwin"))
                    {
                        Method (PKGX, 3, Serialized)
                        {
                            Name (PKG, Package (0x03)
                            {
                                Zero, 
                                Zero, 
                                Zero
                            })
                            PKG [Zero] = Arg0
                            PKG [One] = Arg1
                            PKG [0x02] = Arg2
                            Return (PKG) /* \_SB_.PCI0.I2C1.PKGX.PKG_ */
                        }
                    }

                    If (_OSI ("Darwin"))
                    {
                        Method (SSCN, 0, NotSerialized)
                        {
                            Return (PKGX (SSH1, SSL1, SSD1))
                        }
                    }

                    If (_OSI ("Darwin"))
                    {
                        Method (FMCN, 0, NotSerialized)
                        {
                            Name (PKG, Package (0x03)
                            {
                                0x0101, 
                                0x012C, 
                                0x62
                            })
                            Return (PKG) /* \_SB_.PCI0.I2C1.FMCN.PKG_ */
                        }
                    }

                    Scope (TPD0)
                    {
                        If (_OSI ("Darwin"))
                        {
                            Name (OSYS, 0x07DC)
                        }
                    }
                }

                Scope (LPCB)
                {
                    Device (ARTC)
                    {
                        Name (_HID, "ACPI000E" /* Time and Alarm Device */)  // _HID: Hardware ID
                        Method (_GCP, 0, NotSerialized)  // _GCP: Get Capabilities
                        {
                            Return (0x05)
                        }

                        Method (_STA, 0, NotSerialized)  // _STA: Status
                        {
                            If (_OSI ("Darwin"))
                            {
                                Return (0x0F)
                            }
                            Else
                            {
                                Return (Zero)
                            }
                        }
                    }

                    Device (DMAC)
                    {
                        Name (_HID, EisaId ("PNP0200") /* PC-class DMA Controller */)  // _HID: Hardware ID
                        Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                        {
                            IO (Decode16,
                                0x0000,             // Range Minimum
                                0x0000,             // Range Maximum
                                0x01,               // Alignment
                                0x20,               // Length
                                )
                            IO (Decode16,
                                0x0081,             // Range Minimum
                                0x0081,             // Range Maximum
                                0x01,               // Alignment
                                0x11,               // Length
                                )
                            IO (Decode16,
                                0x0093,             // Range Minimum
                                0x0093,             // Range Maximum
                                0x01,               // Alignment
                                0x0D,               // Length
                                )
                            IO (Decode16,
                                0x00C0,             // Range Minimum
                                0x00C0,             // Range Maximum
                                0x01,               // Alignment
                                0x20,               // Length
                                )
                            DMA (Compatibility, NotBusMaster, Transfer8_16, )
                                {4}
                        })
                        Method (_STA, 0, NotSerialized)  // _STA: Status
                        {
                            If (_OSI ("Darwin"))
                            {
                                Return (0x0F)
                            }
                            Else
                            {
                                Return (Zero)
                            }
                        }
                    }

                    Device (EC)
                    {
                        Name (_HID, "ACID0001")  // _HID: Hardware ID
                        Method (_STA, 0, NotSerialized)  // _STA: Status
                        {
                            If (_OSI ("Darwin"))
                            {
                                Return (0x0F)
                            }
                            Else
                            {
                                Return (Zero)
                            }
                        }
                    }

                    Device (PMCR)
                    {
                        Name (_HID, EisaId ("APP9876"))  // _HID: Hardware ID
                        Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                        {
                            Memory32Fixed (ReadWrite,
                                0xFE000000,         // Address Base
                                0x00010000,         // Address Length
                                )
                        })
                        Method (_STA, 0, NotSerialized)  // _STA: Status
                        {
                            If (_OSI ("Darwin"))
                            {
                                Return (0x0B)
                            }
                            Else
                            {
                                Return (Zero)
                            }
                        }
                    }

                    Scope (PS2K)
                    {
                        If (_OSI ("Darwin"))
                        {
                            Name (RMCF, Package (0x04)
                            {
                                "Keyboard", 
                                Package (0x02)
                                {
                                    "RemapPrntScr", 
                                    ">y"
                                }, 

                                "Keyboard", 
                                Package (0x02)
                                {
                                    "Custom PS2 Map", 
                                    Package (0x03)
                                    {
                                        Package (0x00){}, 
                                        "46=0", 
                                        "e045=0"
                                    }
                                }
                            })
                        }
                    }
                }

                Device (MCHC)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        If (_OSI ("Darwin"))
                        {
                            Return (0x0F)
                        }
                        Else
                        {
                            Return (Zero)
                        }
                    }
                }

                Device (SRAM)
                {
                    Name (_ADR, 0x00140002)  // _ADR: Address
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        If (_OSI ("Darwin"))
                        {
                            Return (0x0F)
                        }
                        Else
                        {
                            Return (Zero)
                        }
                    }
                }

                Device (XSPI)
                {
                    Name (_ADR, 0x001F0005)  // _ADR: Address
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        If (_OSI ("Darwin"))
                        {
                            Return (0x0F)
                        }
                        Else
                        {
                            Return (Zero)
                        }
                    }
                }
            }

            Scope (PR00)
            {
                If (_OSI ("Darwin"))
                {
                    Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                    {
                        If ((Arg2 == Zero))
                        {
                            Return (Buffer (One)
                            {
                                 0x03                                             // .
                            })
                        }

                        Return (Package (0x02)
                        {
                            "plugin-type", 
                            One
                        })
                    }
                }
            }

            Device (USBX)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                {
                    If ((Arg2 == Zero))
                    {
                        Return (Buffer (One)
                        {
                             0x03                                             // .
                        })
                    }

                    Return (Package (0x04)
                    {
                        "kUSBSleepPortCurrentLimit", 
                        0x0BB8, 
                        "kUSBWakePortCurrentLimit", 
                        0x0BB8
                    })
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If (_OSI ("Darwin"))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }

            If (_OSI ("Darwin"))
            {
                Method (LPS0, 0, NotSerialized)
                {
                    Debug = "Method \\_SB._LPS0 Called"
                    Return (One)
                }
            }
        }

        If (_OSI ("Darwin"))
        {
            Name (SLTP, Zero)
            Method (_TTS, 1, NotSerialized)  // _TTS: Transition To State
            {
                SLTP = Arg0
            }
        }

        Method (GPRW, 2, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                If ((0x6D == Arg0))
                {
                    Return (Package (0x02)
                    {
                        0x6D, 
                        Zero
                    })
                }

                If ((0x0D == Arg0))
                {
                    Return (Package (0x02)
                    {
                        0x0D, 
                        Zero
                    })
                }
            }

            Return (XPRW (Arg0, Arg1))
        }
    }
}

