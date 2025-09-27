import type { Logger } from '@n8n/backend-common';
import { mock, MockProxy } from 'jest-mock-extended';

export const mockLogger = (): MockProxy<Logger> & Logger => {
	const scopedLogger = mock<Logger>();
	const logger = mock<Logger>();
	
	// Remplacer directement la fonction scoped par notre propre implémentation
	// sans utiliser mockImplementation qui cause le problème de type
	logger.scoped = (() => scopedLogger) as typeof logger.scoped;

	return logger;
};

export * from './random';
export * as testDb from './test-db';
export * as testModules from './test-modules';
export * from './db/workflows';
export * from './db/projects';
export * from './mocking';
