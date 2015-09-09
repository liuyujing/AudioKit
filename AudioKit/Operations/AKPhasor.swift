//
//  AKPhasor.swift
//  AudioKit
//
//  Autogenerated by scripts by Aurelius Prochazka on 9/9/15.
//  Copyright (c) 2015 Aurelius Prochazka. All rights reserved.
//

import Foundation

/** A normalized moving phase value.

Produces a normalized sawtooth wave between the values of 0 and 1. Phasors are often used when building table-lookup oscillators.
*/
@objc class AKPhasor : AKParameter {

    // MARK: - Properties

    private var phasor = UnsafeMutablePointer<sp_phasor>.alloc(1)

    /** Frequency in cycles per second, or Hz. [Default Value: 1] */
    var frequency: AKParameter = akp(1) {
        didSet { frequency.bind(&phasor.memory.freq) }
    }


    // MARK: - Initializers

    /** Instantiates the phasor with default values */
    override init()
    {
        super.init()
        setup()
        bindAll()
    }

    /**
    Instantiates the phasor with all values

    :param: frequency Frequency in cycles per second, or Hz. [Default Value: 1]
    */
    convenience init(
        frequency freqInput: AKParameter)
    {
        self.init()

        frequency = freqInput

        bindAll()
    }

    // MARK: - Internals

    /** Bind every property to the internal phasor */
    internal func bindAll() {
        frequency.bind(&phasor.memory.freq)
    }

    /** Internal set up function */
    internal func setup() {
        sp_phasor_create(&phasor)
        sp_phasor_init(AKManager.sharedManager.data, phasor)
    }

    /** Computation of the next value */
    override func compute() -> Float {
        sp_phasor_compute(AKManager.sharedManager.data, phasor, nil, &value);
        pointer.memory = value
        return value
    }

    /** Release of memory */
    override func teardown() {
        sp_phasor_destroy(&phasor)
    }
}
